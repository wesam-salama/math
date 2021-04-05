import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class BlocEvents {
  const BlocEvents();
}

class RegisterUserEvent extends BlocEvents {
  String name;
  String gender;
  String password;
  String mobile;
  String levelId;
  String location;
  String supervisor;
  String supervisorType;
  File avatar;
  BuildContext context;
  RegisterUserEvent(
      this.name,
      this.gender,
      this.password,
      this.mobile,
      this.levelId,
      this.location,
      this.supervisor,
      this.supervisorType,
      this.avatar,
      this.context);
}

class GetTokenEvent extends BlocEvents {}

class LogInEvent extends BlocEvents {
  String password;
  String mobile;
  BuildContext context;

  LogInEvent(this.mobile, this.password, this.context);
}

class MeUserEvent extends BlocEvents {}

class LogOutEvent extends BlocEvents {
  String password;
  String mobile;
  BuildContext context;
  LogOutEvent(this.mobile, this.password, this.context);
}

class ConfirmPhoneEvent extends BlocEvents {
  String code;
  BuildContext context;
  ConfirmPhoneEvent(this.code, this.context);
}

class ResetEvent extends BlocEvents {
  String mobile;
  BuildContext context;
  ResetEvent(this.mobile, this.context);
}

class ResetPasswordConfirmEvent extends BlocEvents {
  String mobile;
  String code;
  BuildContext context;
  ResetPasswordConfirmEvent(this.mobile, this.code, this.context);
}

class ResetPasswordConfirmUpdateEvent extends BlocEvents {
  String mobile;
  String token;
  String password;
  BuildContext context;
  ResetPasswordConfirmUpdateEvent(
      this.mobile, this.token, this.password, this.context);
}

class LevelsEvent extends BlocEvents {}

class UnitEvent extends BlocEvents {
  String term;
  String level;
  UnitEvent(this.term, this.level);
}

class UnitTwilvEvent extends BlocEvents {
  String level;
  String mathType;
  String term;

  UnitTwilvEvent(this.level, this.mathType, this.term);
}

class VideoEvent extends BlocEvents {}

class VideoViewEvent extends BlocEvents {
  String id;
  VideoViewEvent(this.id);
}

class OrderPaymebtEvent extends BlocEvents {
  String type;
  int unitId;
  OrderPaymebtEvent(this.type, this.unitId);
}

class MeStatusEvent extends BlocEvents {
  BuildContext context;
  MeStatusEvent(this.context);
}

class CallMeEvent extends BlocEvents {
  BuildContext context;
  CallMeEvent(this.context);
}

class EditProfileEvent extends BlocEvents {
  String name;
  String gender;
  String password;
  String confirmPassword;
  String levelId;
  String location;
  String supervisor;
  String supervisorType;
  BuildContext context;
  EditProfileEvent(
      this.name,
      this.gender,
      this.password,
      this.confirmPassword,
      this.levelId,
      this.location,
      this.supervisor,
      this.supervisorType,
      this.context);
}

class IsAccessVideoEvent extends BlocEvents {
  String videoId;
  Widget route;
  int unitId;
  String level;
  var price;
  var mathType;
  var term;
  BuildContext context;
  IsAccessVideoEvent(this.videoId, this.context, this.route, this.unitId,
      this.level, this.price,
      {this.mathType, this.term});
}

class SettingsEvent extends BlocEvents {}

class NotificationEvent extends BlocEvents {}
