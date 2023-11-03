import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/absen_model.dart';
import 'package:tugasakhirmobile/models/absendetail_model.dart';
import 'package:tugasakhirmobile/models/create_absen_model.dart';
import 'package:tugasakhirmobile/models/error_either.dart';
import 'package:tugasakhirmobile/models/status_absen_model.dart';
import 'package:intl/intl.dart';

abstract class AbsenService {
  Future<Either<ErrorEither, AbsenModel>> findAbsen(
      final int getDay, final int kelasId);
  Future<Either<ErrorEither, StatusAbsen>> statusAbsenData();
  Future<Either<ErrorEither, AbsenDetail>> absenDetail();
  Future<Either<ErrorEither, String>> createAbsen(final CreateAbsen form);
}

class AbsenRepository implements AbsenService {
  final String urlLink = dotenv.env["BASE_URL"]!;
  final dio = Dio();

  @override
  Future<Either<ErrorEither, AbsenModel>> findAbsen(
      final int getDay, final int kelasId) async {
    dio.interceptors.add(PrettyDioLogger());

    try {
      final response = await Dio().get("$urlLink/v2/pelajaran/$getDay/$kelasId",
          options: Options(
            headers: {"x-access-token": await SharedPrefs().getAccessToken()},
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        return Right(AbsenModel.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }

  @override
  Future<Either<ErrorEither, StatusAbsen>> statusAbsenData() async {
    dio.interceptors.add(PrettyDioLogger());

    final idUser = await SharedPrefs().getIdUser();
    final month = DateTime.now().month;
    try {
      final response = await Dio().get("$urlLink/v2/absen/$idUser/$month",
          options: Options(
            headers: {"x-access-token": await SharedPrefs().getAccessToken()},
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        return Right(StatusAbsen.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }

  @override
  Future<Either<ErrorEither, AbsenDetail>> absenDetail() async {
    dio.interceptors.add(PrettyDioLogger());
    final idUser = await SharedPrefs().getIdUser();
    final month = DateTime.now().month;

    try {
      final response = await dio.get("$urlLink/v2/absen/detail/$idUser/$month",
          options: Options(
            headers: {"x-access-token": await SharedPrefs().getAccessToken()},
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        return Right(AbsenDetail.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }

  @override
  Future<Either<ErrorEither, String>> createAbsen(
      final CreateAbsen form) async {
    dio.interceptors.add(PrettyDioLogger());
    final now = DateTime.now();

    final Map<String, dynamic> formData = {
      "user_id": form.userId,
      "guru_id": form.guruId,
      "pelajaran_id": form.pelajaranId,
      "kelas_id": form.kelasId,
      "keterangan": form.keterangan,
      "reason": form.reason,
      "day": "${now.day}",
      "month": "${now.month}",
      "year": "${now.year}",
      "time": DateFormat.Hms().format(now)
    };
    try {
      final response = await Dio().post("$urlLink/v2/absen",
          data: formData,
          options: Options(
            headers: {"x-access-token": await SharedPrefs().getAccessToken()},
            contentType: Headers.formUrlEncodedContentType,
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 201) {
        return const Right("SUCCESSS");
      } else {
        return Left(ErrorEither(400, true, response.data['message']));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }
}
