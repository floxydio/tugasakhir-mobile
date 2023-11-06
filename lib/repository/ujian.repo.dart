import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/check_exam_model.dart';
import 'package:tugasakhirmobile/models/error_either.dart';
import 'package:tugasakhirmobile/models/ujian_data_model.dart';
import 'package:tugasakhirmobile/models/ujian_form_model.dart';
import 'package:tugasakhirmobile/models/ujian_soal_model.dart';

abstract class UjianService {
  Future<Either<ErrorEither, UjianList>> getDataUjian();
  Future<Either<ErrorEither, QuizResponse>> getDetailUjian(final int id);
  Future<Either<ErrorEither, Response>> sendUjian(
      final UjianFormSubmit form, final int id);
  Future<Either<ErrorEither, CheckExamModel>> checkExam(final int idujian);
}

class UjianRepository implements UjianService {
  final String urlLink = dotenv.env["BASE_URL"]!;
  final dio = Dio();

  @override
  Future<Either<ErrorEither, QuizResponse>> getDetailUjian(final int id) {
    dio.interceptors.add(PrettyDioLogger());
    return SharedPrefs().getAccessToken().then((final value) async {
      try {
        final response = await Dio().get("$urlLink/v2/ujian-detail/$id",
            options: Options(
              headers: {"x-access-token": value},
              followRedirects: false,
              validateStatus: (final status) {
                return status! < 500;
              },
            ));
        if (response.statusCode == 200) {
          return Right(QuizResponse.fromJson(response.data));
        } else {
          return Left(ErrorEither(400, true, response.data["message"]));
        }
      } catch (e) {
        return Left(ErrorEither(400, true, e.toString()));
      }
    });
  }

  @override
  Future<Either<ErrorEither, UjianList>> getDataUjian() async {
    dio.interceptors.add(PrettyDioLogger());
    final kelasId = await SharedPrefs().getKelasId();
    try {
      final response = await Dio().get("$urlLink/v2/ujian/$kelasId",
          options: Options(
            headers: {"x-access-token": await SharedPrefs().getAccessToken()},
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        return Right(UjianList.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }

  @override
  Future<Either<ErrorEither, Response>> sendUjian(
      final UjianFormSubmit form, final int id) async {
    dio.interceptors.add(PrettyDioLogger());
    return SharedPrefs().getAccessToken().then((final value) async {
      try {
        final Map<String, dynamic> data = {
          "jawaban_pg": form.jawabanPg,
          "jawaban_essay": form.jawabanEssay,
          "idujian": id,
          "token": value,
        };
        final response = await Dio().post("$urlLink/v2/ujian-submitted",
            data: data,
            options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"x-access-token": value},
              followRedirects: false,
              validateStatus: (final status) {
                return status! < 500;
              },
            ));
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(response);
        } else {
          return Left(ErrorEither(400, true, response.data["message"]));
        }
      } catch (e) {
        return Left(ErrorEither(400, true, e.toString()));
      }
    });
  }

  @override
  Future<Either<ErrorEither, CheckExamModel>> checkExam(final int id) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final response = await Dio().get(
          "$urlLink/v2/check-exam/$id?token=${await SharedPrefs().getAccessToken()}",
          options: Options(
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        return Right(CheckExamModel.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }
}
