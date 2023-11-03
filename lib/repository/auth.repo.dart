import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/error_either.dart';
import 'package:tugasakhirmobile/models/jwt_model.dart';
import 'package:tugasakhirmobile/models/login_model.dart';
import 'package:tugasakhirmobile/models/profileimage_model.dart';

abstract class AuthService {
  Future<Either<ErrorEither, DataJwt>> getRefreshToken();
  Future<Either<ErrorEither, LoginModel>> signIn(
      final String username, final String password);
  Future<Either<ErrorEither, ProfileImage>> imageProfile();
}

class AuthRepository implements AuthService {
  final String urlLink = dotenv.env["BASE_URL"]!;
  final dio = Dio();

  @override
  Future<Either<ErrorEither, DataJwt>> getRefreshToken() async {
    dio.interceptors.add(PrettyDioLogger());

    try {
      final response = await dio.get("$urlLink/v2/refresh-token",
          options: Options(
            headers: {
              "x-access-token": await SharedPrefs().getAccessToken(),
            },
            contentType: Headers.formUrlEncodedContentType,
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(JWTModel.fromJson(response.data).data!);
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }

  @override
  Future<Either<ErrorEither, LoginModel>> signIn(
      final String username, final String password) async {
    dio.interceptors.add(PrettyDioLogger());

    final Map<String, dynamic> data = {"username": username, "password": password};

    try {
      final response = await dio.post("$urlLink/v2/sign-in",
          data: data,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(LoginModel.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data['message']));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }

  @override
  Future<Either<ErrorEither, ProfileImage>> imageProfile() async {
    dio.interceptors.add(PrettyDioLogger());

    try {
      final response = await dio.get(
          "$urlLink/v2/profile-image/${await SharedPrefs().getAccessToken()}",
          options: Options(
            headers: {
              "x-access-token": await SharedPrefs().getAccessToken(),
            },
            followRedirects: false,
            validateStatus: (final status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ProfileImage.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data['message']));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }
}
