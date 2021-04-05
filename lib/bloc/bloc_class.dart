import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pythagoras/components/models/levels.dart';
import 'package:pythagoras/components/models/me_user.dart';
import 'package:pythagoras/components/models/notification_model.dart';
import 'package:pythagoras/components/models/token_data.dart';
import 'package:pythagoras/components/models/unit.dart';
import 'package:pythagoras/components/models/unit_twilv_elvent.dart';
import 'package:pythagoras/components/models/user_data.dart';
import 'package:pythagoras/components/models/video.dart';
import 'package:pythagoras/features/users/GetApp/app_get.dart';
import 'package:pythagoras/features/users/repo/api_user_client.dart';
import 'package:pythagoras/features/users/repo/api_user_repo.dart';
import 'package:pythagoras/features/users/ui/screens/confirm_phone_screen.dart';
import 'package:pythagoras/features/users/ui/screens/home_screen.dart';
import 'package:pythagoras/features/users/ui/screens/log_in_screen.dart';
import 'package:pythagoras/features/users/ui/screens/setting_screen.dart';
import 'package:pythagoras/features/users/ui/screens/update_password.dart';
import 'package:pythagoras/features/users/ui/screens/verification_phone_screen.dart';
import 'package:pythagoras/features/users/ui/widgets/card_payment-dialog.dart';
import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/values/constants.dart';

import 'bloc_events.dart';
import 'bloc_states.dart';

class UserBloc extends Bloc<BlocEvents, BlocStates> {
  UserBloc(BlocStates initialState) : super(initialState);
  UserData userData;
  TokenData tokenData;
  Levels allLevels;
  Unit allUnit;
  UnitTwilvAlivent unitTwilvAlivent;
  Video allVideo;
  MeUser meUser;
  String videoIni;
  Map allSettings;
  Notification1 allNotificaton;
  AppGet authGet = Get.find();

  ///////////////////////////////////////////////////
  Future<Levels> getAllLevels() async {
    if (allLevels == null) {
      print("11111111111111111111111111111");
      Levels levels = await ApiRepositoryUser.apiRepositoryUser.levels();
      print("1111111122222222222222222222222221  $levels");
      allLevels = levels;
      return levels;
    } else {
      return allLevels;
    }
  }

///////////////////////////////////////////////////
  Future<Unit> getAllUnit(String term, String level) async {
    if (allUnit == null) {
      Unit unit = await ApiRepositoryUser.apiRepositoryUser.unit(term, level);
      allUnit = unit;
      return unit;
    } else {
      return allUnit;
    }
  }

  ///////////////////////////////////////////////////
  Future<UnitTwilvAlivent> getAllUnitTwilv(
    String level,
    String mathType,
    String term,
  ) async {
    if (unitTwilvAlivent == null) {
      UnitTwilvAlivent unit = await ApiRepositoryUser.apiRepositoryUser
          .unitTwilvAElevnt(level, mathType, term);
      unitTwilvAlivent = unit;
      return unit;
    } else {
      return unitTwilvAlivent;
    }
  }

  ///////////////////////////////////////////
  Future<Map> getAllSetting() async {
    if (allSettings == null) {
      Map settings = await ApiUserClient.apiUserClient.settingsUser();
      allSettings = settings;
      return settings;
    } else {
      return allSettings;
    }
  }

  @override
  Stream<BlocStates> mapEventToState(BlocEvents event) async* {
    if (event is LogInEvent) {
      try {
        yield TasksLoadingState();
        Map login = await ApiUserClient.apiUserClient
            .loginUser2(event.mobile, event.password);
        if (login == null) {
          Fluttertoast.showToast(
              msg: "تأكد من المدخلات",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          String token = login["access_token"];
          print("i89999911111111111111112222222222222");
          print("dooooooooooooooooooooooone $token");
          if (login["message"] == "success") {
            print("dooooooooooooooooooooooone $token");
            yield UserLogedInState(token);
          } else {
            print("errrrrrrrrrrrrrrrrrrrrrrrrrrror 88888888888888555555555");
          }
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
    ////////////////////////////////////////////////////////////////////
    if (event is RegisterUserEvent) {
      try {
        yield TasksLoadingState();
        Map user = await ApiUserClient.apiUserClient.registerUser(
            event.name,
            event.gender,
            event.password,
            event.mobile,
            event.levelId,
            event.location,
            event.supervisor,
            event.supervisorType,
            event.avatar);

        if (user == null) {
          Fluttertoast.showToast(
              msg: "تأكد من المدخلات",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          if (user['message'] == "User successfully registered") {
            yield SuccessState();
            push(event.context, LogInScreen());
            Fluttertoast.showToast(
                msg: "تم انشاء حساب بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Future.delayed(Duration(milliseconds: 200), () {
              authGet.setCountNotifiSp(0);
              SPHelper.spHelper.setCountNotification(0);
            });
            print("Done Register ${user['message']}");
          } else {
            yield TasksErrorState("غير موجود");
            print("EEEEEErrrrooooooooor222222222222222222222222222");
          }
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
    // ///////////////////////////////////////////////////////////////////
    if (event is LogOutEvent) {
      try {
        yield TasksLoadingState();
        Map map = await ApiUserClient.apiUserClient
            .logOutUser(event.mobile, event.password);
        if (map == null) {
          Fluttertoast.showToast(
              msg: "فشل تسجيل الخروج",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          if (map["message"] == "Successfully logged out") {
            yield UserLogedOutState(map["message"]);
          }
          UserLogedOutState(map["message"]);
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
    // ///////////////////////////////////////////////////////////////////

    if (event is MeUserEvent) {
      try {
        yield TasksLoadingState();
        MeUser user2 = await ApiRepositoryUser.apiRepositoryUser.meUser();
        if (user2.name != "") {
          yield MeUserState(user2);
          print("Done Me User ${user2.name}");
        } else {
          print("EEEEEErrrrooooooooor333333333333333333333");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
    ////////////////////////////////////////////////////
    if (event is ResetEvent) {
      try {
        yield TasksLoadingState();
        Map map =
            await ApiUserClient.apiUserClient.passwordResetUser(event.mobile);
        if (map == null) {
          Fluttertoast.showToast(
              msg: "تأكد من المدخلات",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          if (map["message"] == "success") {
            print("ghghghghghghghhhhhhhhhhhhhhhhhhhhhhhhh ${map["status"]}");

            yield ResetState(map["status"]);
            pushReplecment(event.context, VerificationPhoneScreen());
            Fluttertoast.showToast(
                msg: "تم ارسال رمز التفعيل",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            print("EEEEEErrrrooooooooor4444444444444444444444");
          }
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    //////////////////////////////////////////////
    if (event is ResetPasswordConfirmEvent) {
      try {
        yield TasksLoadingState();
        Map map = await ApiUserClient.apiUserClient
            .resetPasswordConfirmUser(event.mobile, event.code);
        if (map == null) {
          Fluttertoast.showToast(
              msg: "تأكد من المدخلات",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          if (map["token"] != null) {
            yield ResetPasswordConfirmState(map["status"], map["token"]);
            pushAndRemoveUntil(event.context, UpdatePassword());
          } else {
            print("EEEEEErrrrooooooooor555555555555");
          }
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    ///////////////////////////////////////
    ///
    if (event is ResetPasswordConfirmUpdateEvent) {
      try {
        yield TasksLoadingState();
        Map map = await ApiUserClient.apiUserClient
            .resetPasswordConfirmUpdateUser(
                event.mobile, event.token, event.password);
        if (map == null) {
          Fluttertoast.showToast(
              msg: "تأكد من المدخلات",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          if (map["status"] == "success") {
            yield ResetPasswordConfirmUpdateState(map["status"]);
            pushAndRemoveUntil(event.context, LogInScreen());
            Fluttertoast.showToast(
                msg: "تم تعديل كلمة المرور",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            print("EEEEEErrrrooooooooor555555555555");
          }
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    //////////////////////////////////////////
    if (event is ConfirmPhoneEvent) {
      try {
        yield TasksLoadingState();
        Map map =
            await ApiUserClient.apiUserClient.confirmPhoneUser(event.code);
        if (map == null) {
          Fluttertoast.showToast(
              msg: "تأكد من المدخلات",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          if (map["status"] == "success") {
            print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk6666666666666666");
            yield ConfirmPhoneState(map["status"]);
            pushAndRemoveUntil(event.context, HomeScreen());
            Fluttertoast.showToast(
                msg: "تم تأكيد الحساب بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            print("EEEEEErrrrooooooooor6666666666666666");
          }
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
    /////////////////////////////////////////
    if (event is LevelsEvent) {
      try {
        yield TasksLoadingState();
        Levels levels1 = await getAllLevels();
        print("fffffffggggggggggggg $levels1");
        if (levels1.data != null) {
          yield LevelsState(levels1.data);
        } else {
          print(
              "lllllllllleeeeeeeeeeeeeeeeeeeeeeeeeeeeeellllllllllllllllllllll");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    ////////////////////////////////////////////
    if (event is UnitEvent) {
      try {
        yield TasksLoadingState();
        Unit unit1 = await ApiRepositoryUser.apiRepositoryUser
            .unit(event.term, event.level);
        if (unit1.data != null) {
          print("unit ${unit1.data}");
          yield UnitState(unit1.data);
        } else {}
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    ////////////////////////////////////////////
    if (event is UnitTwilvEvent) {
      try {
        print("unit 11111111111111111111111111111111");
        yield TasksLoadingState();
        print(
            "xbxbxbbxbxbxbxbxxbbxbxbx  ${event.level} , ${event.mathType} , ${event.term}");
        UnitTwilvAlivent unit1 = await ApiRepositoryUser.apiRepositoryUser
            .unitTwilvAElevnt(event.level, event.mathType, event.term);
        if (unit1.data != null) {
          print("unit 2222222222222222 ${unit1.data.first.title}");
          print("unit ${unit1.data}");
          yield UnitTwilvState(unit1.data);
        } else {
          print("unit 33333333333333333333333333333333333");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
    ////////////////////////////////////////
    if (event is VideoEvent) {
      try {
        yield TasksLoadingState();
        Video video1 = await ApiRepositoryUser.apiRepositoryUser.videoUser();
        // Provider.of(context).setVideoOflineUrl("https://api.pythagorath.com/storage/videos/${videoDataOfline[0].path}");
        // List<VideoData> videoDataOfline =
        //     video1.data.where((element) => element.type == "OFFLINE").toList();
        if (video1.data != null) {
          // videoIni =
          //     "https://api.pythagorath.com/storage/videos/${videoDataOfline[0].path}";
          // yield SetVideoState(
          //     "https://api.pythagorath.com/storage/videos/${videoDataOfline[0].path}");
          yield VideoState(video1.data);
        } else {
          print("bbbbbbbbbbbbbbbbbbbbbbbnnnnnnnnnnnnnn");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    ////////////////////////////////////////

    ////////////////////////////////////////
    if (event is VideoViewEvent) {
      try {
        yield TasksLoadingState();
        String video = await ApiUserClient.apiUserClient.videwView(event.id);
        if (video != null) {
          yield VideoViewState(video);
        } else {
          print("bbbbbbbbbbbbbbbbbbbbbbbnnnnnnnnnnnnnn");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    if (event is OrderPaymebtEvent) {
      try {
        yield TasksLoadingState();
        Map map = await ApiUserClient.apiUserClient
            .orderPaymentUser(event.type, event.unitId);
        if (map["status"] == true) {
          yield OrderPaymentState(map["redirect"]);
        } else {
          print("ppppppppppppppppppppeeeeeeeeeeeeeeeeeeeeeeeeeee");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    //////////////////////////////////////////
    if (event is MeStatusEvent) {
      try {
        yield TasksLoadingState();
        Map map = await ApiUserClient.apiUserClient.meStatusUser();
        if (map["phoneVerified"] != 2) {
          yield MeStatusState(
              map["isAdmin"], map["phoneVerified"], map["blocked"]);

          if (map["blocked"] == 1) {
            Fluttertoast.showToast(
                msg: "ثم تعطيل حسابك , راجع ادارة التطبيق",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            pushAndRemoveUntil(event.context, LogInScreen());
          } else {
            if (map["phoneVerified"] == 1) {
              print(
                  "mnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
              pushAndRemoveUntil(event.context, HomeScreen());
            } else {
              print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
              push(event.context, ConfirmPhoneScreen());
            }
          }
        } else {
          print("EEEEEErrrrooooooooor6666666666666666");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    //////////////////////////////////////////
    if (event is CallMeEvent) {
      try {
        yield TasksLoadingState();
        Map map = await ApiUserClient.apiUserClient.callMe();
        if (map["message"] != null) {
          yield CallMeState(map["message"]);
          // Navigator.of(event.context).pop();
        } else {
          print("EEEEEErrrrooooooooor6666666666666666");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    //////////////////////////////////////////
    if (event is EditProfileEvent) {
      try {
        yield TasksLoadingState();
        print("oopppppppppppppppppppyyyyyyyyyyyyyyyyyyrrrrrrrrrrrrr");
        Map map = await ApiUserClient.apiUserClient.editProfile(
            event.name,
            event.gender,
            event.levelId,
            event.location,
            event.supervisor,
            event.supervisorType,
            event.password,
            event.confirmPassword);
        if (map == null) {
          Fluttertoast.showToast(
              msg: "تأكد من المدخلات",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EmptyTasksState();
        } else {
          if (map["message"] == "success") {
            yield EditProfileState(map["message"]);
            Fluttertoast.showToast(
                msg: "تم تعديل البيانات بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            push(event.context, SettingScreen());
          } else {
            print("EEEEEErrrrooooooooor6666666666666666");
          }
        }
      } catch (e) {
        print("oo222222222222222222222222222yyyyyyyyyyyyyyyyyrrrrrrrrrrrrr");
        yield TasksErrorState(e.toString());
      }
    }

    //////////////////////////////////////////
    if (event is IsAccessVideoEvent) {
      try {
        yield TasksLoadingState();
        String map = await ApiUserClient.apiUserClient.isAccessVideo(
          event.videoId,
        );
        if (map == "1") {
          yield EditProfileState(map);
          push(event.context, event.route);
        } else {
          showDialog(
            context: event.context,
            builder: (context) {
              print("raaaaaaaaam ccccccccccccc ${event.unitId}");
              return CardPaymentDialog(
                unitId: event.unitId,
                level: event.level,
                price: event.price,
                mathh: event.mathType,
                term: event.term,
              );
            },
          );
          print("EEEEEErrrrooooooooor6666666666666666");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    /////////////////////////////////////////
    if (event is SettingsEvent) {
      try {
        yield TasksLoadingState();
        Map data1 = await ApiUserClient.apiUserClient.settingsUser();
        if (data1 != null) {
          yield SettingsState(data1);
        } else {}
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }

    /////////////////////////////////////////
    if (event is NotificationEvent) {
      try {
        yield TasksLoadingState();
        Notification1 data1 =
            await ApiRepositoryUser.apiRepositoryUser.allNotification();
        if (data1 != null) {
          yield NotificationState(data1);
        } else {
          print(
              "lllllllllleeeeeeeeeeeeeeeeeeeeeeeeeeeeeellllllllllllllllllllll");
        }
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
  }
}
