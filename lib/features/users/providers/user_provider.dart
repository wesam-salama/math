import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pythagoras/features/users/repo/api_user_client.dart';

class UserProvider extends ChangeNotifier {
  Map mapVideoAccess;
  String link = "";
  getVideoAccess(String videoId) async {
    Map map = await ApiUserClient.apiUserClient.videoAccessById(videoId);
    this.mapVideoAccess = map;
    this.link = map["data"];
    print("vvvvvvvvvvvvvvvvvvvvv ${map["data"]}");
    return map;
  }
}
