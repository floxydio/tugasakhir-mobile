import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/error_either.dart';
import 'package:tugasakhirmobile/models/guru_models.dart';

abstract class GuruService {
  Future<Either<ErrorEither, GuruModel>> getDataGuru();
}

class GuruRepository implements GuruService {
  final String urlLink = dotenv.env["BASE_URL"]!;
  final dio = Dio();

  @override
  Future<Either<ErrorEither, GuruModel>> getDataGuru() async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final response = await dio.get("$urlLink/v2/guru",
          options: Options(
            headers: {"x-access-token": await SharedPrefs().getAccessToken()},
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        return Right(GuruModel.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }
}
