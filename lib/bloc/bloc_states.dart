import 'package:pythagoras/components/models/levels.dart';
import 'package:pythagoras/components/models/me_user.dart';
import 'package:pythagoras/components/models/notification_model.dart';
import 'package:pythagoras/components/models/unit.dart';
import 'package:pythagoras/components/models/unit_twilv_elvent.dart';
import 'package:pythagoras/components/models/user_data.dart';
import 'package:pythagoras/components/models/video.dart';

abstract class BlocStates {
  const BlocStates();
}

class TasksLoadingState extends BlocStates {}

class UserRegesteredState extends BlocStates {
  UserData user;
  UserRegesteredState(this.user);
}

class TasksErrorState extends BlocStates {
  String error;
  TasksErrorState(this.error);
}

class EmptyTasksState extends BlocStates {}

class SuccessState extends BlocStates {}

class UserLogedInState extends BlocStates {
  String token;
  UserLogedInState(this.token);
}

class UserLogedOutState extends BlocStates {
  String message;
  UserLogedOutState(this.message);
}

class MeUserState extends BlocStates {
  MeUser meUser;
  MeUserState(this.meUser);
}

class ConfirmPhoneState extends BlocStates {
  String status;
  ConfirmPhoneState(this.status);
}

class ResetState extends BlocStates {
  String status;
  ResetState(this.status);
}

class ResetPasswordConfirmState extends BlocStates {
  String status;
  String token;
  ResetPasswordConfirmState(this.status, this.token);
}

class ResetPasswordConfirmUpdateState extends BlocStates {
  String status;
  ResetPasswordConfirmUpdateState(this.status);
}

class LevelsState extends BlocStates {
  List<LevelsData> data;
  LevelsState(this.data);
}

class UnitState extends BlocStates {
  List<UnitData> data;
  UnitState(this.data);
}
class UnitTwilvState extends BlocStates {
  List<UnitTwilvAliventData> data;
  UnitTwilvState(this.data);
}


class VideoState extends BlocStates {
  List<VideoData> data;
  VideoState(this.data);
}

class VideoViewState extends BlocStates {
  String data;
  VideoViewState(this.data);
}

class OrderPaymentState extends BlocStates {
  String redirect;
  OrderPaymentState(this.redirect);
}

class MeStatusState extends BlocStates {
  int isAdmin;
  int phoneVerified;
  int blocked;
  MeStatusState(this.isAdmin, this.phoneVerified, this.blocked);
}

class CallMeState extends BlocStates {
  String status;
  CallMeState(this.status);
}

class EditProfileState extends BlocStates {
  String status;
  EditProfileState(this.status);
}

class IsAccessVideoState extends BlocStates {
  String isAccess;
  IsAccessVideoState(this.isAccess);
}

class SettingsState extends BlocStates {
  Map data;
  SettingsState(this.data);
}

class NotificationState extends BlocStates {
  Notification1 notification1;
  NotificationState(this.notification1);
}
