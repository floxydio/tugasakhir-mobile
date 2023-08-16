import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugasakhirmobile/constant/shared_pref.dart';
import 'package:tugasakhirmobile/models/error_either.dart';
import 'package:tugasakhirmobile/models/nilai_model.dart';

abstract class NilaiService {
  Future<Either<ErrorEither, NilaiData>> getNilaiBySemester(int semester);
}

class NilaiRepository implements NilaiService {
  final String urlLink = dotenv.env["BASE_URL"]!;
  final dio = Dio();

  @override
  Future<Either<ErrorEither, NilaiData>> getNilaiBySemester(
      int semester) async {
    try {
      var response =
          await Dio().get("$urlLink/v2/nilai?id=$id&semester=$semester",
              options: Options(
                headers: {
                  "x-access-token": await SharedPrefs().getAccessToken()
                },
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
              ));
      if (response.statusCode == 200) {
        return Right(NilaiData.fromJson(response.data));
      } else {
        return Left(ErrorEither(400, true, response.data["message"]));
      }
    } catch (e) {
      return Left(ErrorEither(400, true, e.toString()));
    }
  }
}
