import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
 import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiUserClient {
  ApiUserClient._();
  static ApiUserClient apiUserClient = ApiUserClient._();

  Dio dio;

  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  http.Client client;
  initApi2() {
    if (client == null) {
      client = http.Client();
      return client;
    } else {
      return client;
    }
  }

  Future<Map> loginUser2(
    String mobile,
    String password,
  ) async {
    try {
      client = await initApi2();
      print('4444444555555555555555444444444445555555');
      http.Response response = await client.post(basePath + logInPath, body: {
        'phone': mobile,
        'password': password,
      }, headers: {
        HttpHeaders.acceptHeader: '*/*',
      });
      print('666666666666666666666666666666 ${response.body}');
      if (response.statusCode == 401) {
        return null;
        // Fluttertoast.showToast(
        //     msg: "رقم الهاتف او كلمة المرور غير صحيحة",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }

      Map map = json.decode(response.body) as Map;
      return map;
    } catch (e) {
      print(e.message);

      return null;
    }
  }

  Future<Map> registerUser(
      String name,
      String gender,
      String password,
      String mobile,
      String levelId,
      String location,
      String supervisor,
      String supervisorType,
      File avatar) async {
    try {
      await initApi();
      FormData formData = FormData.fromMap(
        {
          'name': name,
          'gender': gender,
          'password': password,
          'phone': mobile,
          'level_id': levelId,
          'location': location,
          'supervisor': supervisor,
          'supervisor_type': supervisorType,
          'avatar': await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.path.split('/').last,
            contentType: MediaType("image", "jpg"),
          )
        },
      );
      Response response = await dio.post(basePath + regesterPath,
          data: formData,
          options: Options(headers: {
            Headers.acceptHeader: '*/*',
            Headers.contentTypeHeader: 'multipart/form-data',
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print("eeeeeeeeee22eeeeeeeeeeeeeeeeeeeeeeeeeeee ${e.toString()}");
      return null;
    }
  }

  // Future<Map> logInUser(
  //   String mobile,
  //   String password,
  // ) async {
  //   try {
  //     await initApi();
  //     FormData formData = FormData.fromMap(
  //       {
  //         "phone": mobile,
  //         "password": password,
  //       },
  //     );
  //     Response response = await dio.post(basePath + logInPath,
  //         data: formData,
  //         options: Options(headers: {
  //           Headers.acceptHeader: "*/*",
  //           // Headers.contentTypeHeader: "multipart/form-data",
  //         }));
  //     print(
  //         "8888888888889999999999999999999999999999999 ${response.statusCode}");
  //     if (response.statusCode != 200) {
  //       print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  //     }
  //     return response.data;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future<Map> meStatusUser() async {
    try {
      String token = await SPHelper.spHelper.getToken();
      await initApi();
      Response response = await dio.get(basePath + meStatusPath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> meUser() async {
    try {
      String token = await SPHelper.spHelper.getToken();
      await initApi();
      print("88888888888888888888888888888888888888888");
      Response response = await dio.post(basePath + mePath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print("88888888888888888888888888888888888888888");
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> logOutUser(
    String mobile,
    String password,
  ) async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      FormData formData = FormData.fromMap(
        {
          "phone": mobile,
          "password": password,
        },
      );

      Response response = await dio.post(basePath + logOutPath,
          data: formData,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> confirmPhoneUser(
    String code,
  ) async {
    try {
      String token = await SPHelper.spHelper.getToken();
      await initApi();
      FormData formData = FormData.fromMap(
        {
          "code": code,
        },
      );

      Response response = await dio.post(basePath + confirmPhonePath,
          data: formData,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> passwordResetUser(
    String mobile,
  ) async {
    try {
      String token = await SPHelper.spHelper.getToken();
      await initApi();
      FormData formData = FormData.fromMap(
        {
          "phone": mobile,
        },
      );

      Response response = await dio.post(basePath + passwordResetPath,
          data: formData,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> resetPasswordConfirmUser(
    String mobile,
    String code,
  ) async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      FormData formData = FormData.fromMap(
        {"phone": mobile, "code": code},
      );

      Response response = await dio.post(basePath + resetPasswordConfirmPath,
          data: formData,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> resetPasswordConfirmUpdateUser(
      String mobile, String token, String password) async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      FormData formData = FormData.fromMap(
        {"phone": mobile, "token": token, "password": password},
      );

      Response response =
          await dio.post(basePath + resetPasswordConfirmUpdatePath,
              data: formData,
              options: Options(headers: {
                Headers.acceptHeader: "*/*",
                Headers.contentTypeHeader: "multipart/form-data",
                HttpHeaders.authorizationHeader: "bearer $token"
              }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////
  Future<Map> levels() async {
    try {
      String token = await SPHelper.spHelper.getToken();
      initApi();
      Response response = await dio.get(basePath + levelsPath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(" ${response.data}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////////////////////////////////////////////////////////////

  Future<Map> videosUser() async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      print("ppppppppppppppppppppppppppppppppppppppp");
      Response response = await dio.get(basePath + videosPath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print("oooooooooooooooooooooooooooooooooooooooooooo");
      print(response.data);
      //  List<VideoData> videoDataOfline = response.data
      //         .where((element) => element.type == "OFFLINE")
      //         .toList();
      //     Provider.of<AuthProviderUser>(context,listen: false).setVideoOflineUrl(
      //         "https://api.pythagorath.com/storage/videos/${videoDataOfline[0].path}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////////////////////////////////////////////////////////////

  Future<Map> videosUserPage(String levelId, String unitId) async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      print("ppppppppppppppppppppppppppppppppppppppp");
      Response response =
          await dio.get(basePath + "/videos?unit_id=$unitId&level_id=$levelId",
              options: Options(headers: {
                Headers.acceptHeader: "*/*",
                Headers.contentTypeHeader: "multipart/form-data",
                HttpHeaders.authorizationHeader: "bearer $token"
              }));
      print("oooooooooooooooooooooooooooooooooooooooooooo");
      print(response.data);
      //  List<VideoData> videoDataOfline = response.data
      //         .where((element) => element.type == "OFFLINE")
      //         .toList();
      //     Provider.of<AuthProviderUser>(context,listen: false).setVideoOflineUrl(
      //         "https://api.pythagorath.com/storage/videos/${videoDataOfline[0].path}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///////////////////////////////////////////////////

  Future<Map> unitsUser(String term, String level) async {
    try {
      String token = await SPHelper.spHelper.getToken();
      await initApi();
      Response response =
          await dio.get(basePath + "/units?term=$term&level=$level",
              options: Options(headers: {
                Headers.acceptHeader: "*/*",
                Headers.contentTypeHeader: "multipart/form-data",
                HttpHeaders.authorizationHeader: "bearer $token"
              }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///////////////////////////////////////////////////

  Future<Map> unitsTwilvAndElevent(
    String level,
    String mathType,
    String term,
  ) async {
    try {
      String token = await SPHelper.spHelper.getToken();
      await initApi();
      Response response = await dio.get(
          basePath + "/units?level_id=$level&math_type=$mathType&term=$term",
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////////////////////////////////////////
  Future<Map> settingsUser() async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(basePath + settingsPath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));

      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////////////////////////////////////////////////////
  Future<String> videwView(String id) async {
    try {
      await initApi();
      Response response = await dio.get(basePath + "/videos/$id/view",
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
          }));

      print("bnnnnnnnnnnnnnnnnnnnnnnnbbbbbbbbbbbbb ${response.data}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////////////////////////////////////////////////////
  Future<Map> statisticsUser() async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(basePath + statisticsPath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));

      print("bnnnnnnnnnnnnnnnnnnnnnnnbbbbbbbbbbbbb ${response.data}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////////////////////////////////////////////////////
  Future<Map> orderPaymentUser(String type, int unitId) async {
    try {
      String token = await SPHelper.spHelper.getToken();
      await initApi();
      FormData formData = FormData.fromMap(
        {
          'type': type,
          'unit_id': unitId,
        },
      );
      Response response = await dio.post(basePath + orderPaymentPath,
          data: formData,
          options: Options(headers: {
            Headers.acceptHeader: '*/*',
            Headers.contentTypeHeader: 'multipart/form-data',
            HttpHeaders.authorizationHeader: "bearer $token"
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ${e.toString()}");
      return null;
    }
  }

  ///////////////////////////////////////////////////////
  Future<Map> callMe() async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.post(basePath + callMePath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));

      print("bnnnnnnnnnnnnnnnnnnnnnnnbbbbbbbbbbbbb ${response.data}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /////////////////////////////////////////////
  Future<Map> editProfile(
    String name,
    String gender,
    String levelId,
    String location,
    String supervisor,
    String supervisorType,
    String password,
    String confirmPassword,
  ) async {
    try {
      String token = await SPHelper.spHelper.getToken();
      client = await initApi2();

      print("1111111111222222222222222222");
      http.Response response =
          await client.post(basePath + editProfilePath, body: {
        "name": name,
        "gender": gender,
        "level_id": levelId,
        "location": location,
        "supervisor": supervisor,
        "supervisor_type": supervisorType,
        "password": password,
        "password_confirmation": confirmPassword
      }, headers: {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.authorizationHeader: "bearer $token",

        // Headers.contentTypeHeader: 'multipart/form-data',
      });
      print("77777777774444444444444444444444444441");

      Map map = json.decode(response.body) as Map;
      print("777777788888888888888888 $map");
      return map;
    } catch (e) {
      print(e.message);

      return null;
    }
  }

  ///////////////////////////////////////////////////////
  Future<String> isAccessVideo(String videoId) async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      Response response =
          await dio.get(basePath + "/my/has_access_to_video/$videoId",
              options: Options(headers: {
                Headers.acceptHeader: "*/*",
                Headers.contentTypeHeader: "multipart/form-data",
                HttpHeaders.authorizationHeader: "bearer $token"
              }));

      print("bnnnnnnnnnnnnnnnnnnnnnnnbbbbbbbbbbbbb ${response.data}");
      return response.data.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///////////////////////////////////////////////////////
  Future<Map> videoAccessById(String videoId) async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(basePath + "/videos/$videoId/access",
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));

      print("bnnnnnnnnnnnnnnnnnnnnnnnbbbbbbbbbbbbb ${response.data}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///////////////////////////////////////////////////////
  Future<Map> allNotification() async {
    try {
      await initApi();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(basePath + notificationPath,
          options: Options(headers: {
            Headers.acceptHeader: "*/*",
            Headers.contentTypeHeader: "multipart/form-data",
            HttpHeaders.authorizationHeader: "bearer $token"
          }));

      print("bnnnnnnnnnnnnnnnnnnnnnnnbbbbbbbbbbbbb ${response.data}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
