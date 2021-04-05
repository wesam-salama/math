import 'package:pythagoras/components/models/levels.dart';
import 'package:pythagoras/components/models/me_user.dart';
import 'package:pythagoras/components/models/unit.dart';
import 'package:pythagoras/components/models/unit_twilv_elvent.dart';
import 'package:pythagoras/components/models/video.dart';
import 'package:pythagoras/features/users/repo/api_user_client.dart';
import 'package:pythagoras/components/models/notification_model.dart';

class ApiRepositoryUser {
  ApiRepositoryUser._();

  static ApiRepositoryUser apiRepositoryUser = ApiRepositoryUser._();

  Future<MeUser> meUser() async {
    try {
      Map map = await ApiUserClient.apiUserClient.meUser();

      MeUser meUser = MeUser.fromJson(map);
      print('my users $meUser');
      return meUser;
    } catch (e) {
      return null;
    }
  }

  Future<Levels> levels() async {
    try {
      Map map = await ApiUserClient.apiUserClient.levels();
      print('my map $map');

      Levels levels = Levels.fromJson(map);
      print('rtrtrtrttttttteeeeeeeeeeeeeeeeeeeeeeetttttttrtrts $levels');
      return levels;
    } catch (e) {
      return null;
    }
  }

  Future<Unit> unit(String term, String level) async {
    try {
      Map map = await ApiUserClient.apiUserClient.unitsUser(term, level);
      Unit unit = Unit.fromJson(map);

      return unit;
    } catch (e) {
      return null;
    }
  }

  Future<UnitTwilvAlivent> unitTwilvAElevnt(
    String level,
    String mathType,
    String term,
  ) async {
    try {
      Map map = await ApiUserClient.apiUserClient
          .unitsTwilvAndElevent(level, mathType, term);
      UnitTwilvAlivent unitTwilvAlivent = UnitTwilvAlivent.fromJson(map);

      return unitTwilvAlivent;
    } catch (e) {
      return null;
    }
  }

  Future<Video> videoUser() async {
    try {
      Map map = await ApiUserClient.apiUserClient.videosUser();
      Video video = Video.fromJson(map);

      return video;
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoData>> videoUserPage(String levelId, String unitId) async {
    try {
      Map map =
          await ApiUserClient.apiUserClient.videosUserPage(levelId, unitId);
      Video video = Video.fromJson(map);
      List<VideoData> myVideo = video.data;

      return myVideo;
    } catch (e) {
      return null;
    }
  }

  Future<Notification1> allNotification() async {
    try {
      Map map = await ApiUserClient.apiUserClient.allNotification();
      Notification1 notification1 = Notification1.fromJson(map);

      return notification1;
    } catch (e) {
      return null;
    }
  }
}
