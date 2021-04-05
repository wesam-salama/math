import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:string_validator/string_validator.dart';

class AuthProviderUser extends ChangeNotifier {
  String mobile;
  String password;
  String name;
  String confirmPassword;
  String fatherName;
  String link;
  File imageProfile;
  bool isLive = false;
  String videoOflineUrl;
  String isAdmin;
  int phoneVerified;
  String blocked;
  String location;
  bool isEmpty = false;

  setIsEmpty(bool value) {
    this.isEmpty = value;
    notifyListeners();
  }

  setLocation(String value) {
    this.location = value;
   // notifyListeners();
  }

  setIsAdmin(String value) {
    this.isAdmin = value;
   // notifyListeners();
  }

  setPhoneVerified(int value) {
    this.phoneVerified = value;
   // notifyListeners();
  }

  setBlocked(String value) {
    this.blocked = value;
   // notifyListeners();
  }

  setVideoOflineUrl(String value) {
    this.videoOflineUrl = value;
    notifyListeners();
  }

  Future<String> getVideoOfline() async {
    return videoOflineUrl;
  }

  setIsLive() {
    this.isLive = !this.isLive;
    notifyListeners();
  }

  setImageProfile(File value) {
    this.imageProfile = value;
    notifyListeners();
  }

  List<String> className = [
    "الصف الخامس",
    "الصف السادس",
    "الصف السابع",
    "الصف الثامن",
    "الصف التاسع",
    "الصف العاشر",
    "الصف الحادي عشر",
    "الصف الثاني عشر"
  ];
  List<String> state = ["الرياض", "المدينه المنوره", "مكة", "جدة", "الطائف"];

  String valueClass;
  String valueState;

  List<String> gender = ["ذكر", "انثى"];
  String valueGender;

  String birthday = "تاريخ الميلاد";

  String initialVideo = "IdbyTjI1ZFo";
  String titlePay = "";
  String subTitlePay = "";
  String titleLive = "";
  String subTitleLive = "";
  int countNotification = 0;
  int countNotificationSp = 0;
  setInitialVideo(String value) {
    this.initialVideo = value;
    print("ttttrrrrrrrrrrrrrrrrrrrrrrrrrr $initialVideo");
    //notifyListeners();
  }

  setCountNotification(int value) {
    this.countNotification = value;
    // notifyListeners();
  }

  setCountNotificationSp(int value) {
    this.countNotificationSp = value;
    print("ssssssssssssppppppppppp $value");
    // notifyListeners();
  }

  settitlePay(String value) {
    this.titlePay = value;
    //notifyListeners();
  }

  setsubTitlePay(String value) {
    this.subTitlePay = value;
    //notifyListeners();
  }

  settitleLive(String value) {
    this.titleLive = value;
    //notifyListeners();
  }

  setsubTitleLive(String value) {
    this.subTitleLive = value;
    //notifyListeners();
  }

  setValueBirthday(String value) {
    this.birthday = value;
  //  notifyListeners();
  }

  setName(String value) {
    this.name = value;
    //notifyListeners();
  }

  setFatherName(String value) {
    this.fatherName = value;
  //  notifyListeners();
  }

  setLink(String value) {
    this.link = value;
   // notifyListeners();
  }

  setValueGender(String value) {
    this.valueGender = value;
    //notifyListeners();
  }

  setValueClass(String value) {
    this.valueClass = value;
    var neee = className.indexOf("$valueClass");
    print("rrrrrrrmaaaaaaaaaaaaaaaaaaazzzzzzzzzzzz $neee");
   // notifyListeners();
  }

  setValueState(String value) {
    this.valueState = value;
 //   notifyListeners();
  }

  setMobile(String value) {
    this.mobile = value;
  //  notifyListeners();
  }

  setPassword(String value) {
    this.password = value;
   // notifyListeners();
  }

  setConfirmPassword(String value) {
    this.confirmPassword = value;
  //  notifyListeners();
  }

  validateMobile(String value) {
    if (value == null || value == '') {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    } else if (!isNumeric(value)) {
      return "الرقم الذي ادخلته خاطئ";
    } else if (value.length < 8) {
      return "الرقم الذي ادخلته خاطئ";
    }
    notifyListeners();
  }

  validatePassword(String value) {
    // if (value == null || value == '') {
    //   return "لا يمكن ان يكون هذا الحقل فارغ";
    // } else if (value.length < 8) {
    //   return "كلمة المرور يجب انت تكون على الاقل 8 حروف";
    // }
    // notifyListeners();
  }

  validateConfirmPassword(String value) {
    if (value == null || value == '') {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    } else if (value.length < 8) {
      return "كلمة المرور يجب انت تكون على الاقل 8 حروف";
    }
    notifyListeners();
  }

  validateName(String value) {
    if (value == null || value == '') {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    }
    notifyListeners();
  }

  validateLocation(String value) {
    if (value == null || value == '') {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    }
    notifyListeners();
  }

  validateFatherName(String value) {
    if (value == null || value == '') {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    }
    notifyListeners();
  }

  validateLink(String value) {
    if (value == null || value == '') {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    }
    notifyListeners();
  }

  onSavedLoginForm(BuildContext context, GlobalKey<FormState> loginFormkey) {
    if (loginFormkey.currentState.validate()) {
      loginFormkey.currentState.save();
      BlocProvider.of<UserBloc>(context)
          .add(LogInEvent(mobile, password, context));

      // notifyListeners();

    } else {}
  }

  onSavedRegisterForm(
      BuildContext context, GlobalKey<FormState> registerFormkey) {
    if (registerFormkey.currentState.validate()) {
      registerFormkey.currentState.save();
      int classe = className.indexOf("$valueClass");
      String valueGender1 = valueGender == "ذكر" ? "MALE" : "FEMALE";
      if (imageProfile == null) {
        Fluttertoast.showToast(
            msg: "الرجاء ادخال صوره ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        BlocProvider.of<UserBloc>(context).add(RegisterUserEvent(
            name,
            valueGender1,
            password,
            mobile,
            "${classe + 1}",
            location,
            fatherName,
            link,
            imageProfile,
            context));
      }

      //  push(context, LogInScreen());

      // notifyListeners();

    } else {}
  }

  onSavedEditProfileForm(
      BuildContext context, GlobalKey<FormState> editProfileFormkey) {
    print("111111111111111111111111111111");
    if (editProfileFormkey.currentState.validate()) {
      editProfileFormkey.currentState.save();
      int classe1 = className.indexOf("$valueClass");
      String valueGender11 = valueGender == "ذكر" ? "MALE" : "FEMALE";

      print("objectttttttttttttttttttttttttttttt  $classe1  $valueGender11");
      BlocProvider.of<UserBloc>(context).add(EditProfileEvent(
          name,
          valueGender11,
          password,
          password,
          "${classe1 + 1}",
          location,
          fatherName,
          link,
          context));
      print("1222222222222222222222222222");
      BlocProvider.of<UserBloc>(context).add(MeUserEvent());
      //  push(context, LogInScreen());

      // notifyListeners();

    } else {}
  }
}
