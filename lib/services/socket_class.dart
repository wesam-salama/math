import 'package:flutter/material.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/features/users/GetApp/app_get.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/services/notification_handler.dart';
import 'package:pythagoras/services/sp_helper.dart';

class SocketHandel {
  Echo echo;
  bool isConnected = false;
  String channelType = 'public';
  String channelName = 'notification';
  String event = 'PushNotification';
  FlutterPusher pusherClient;
  dynamic channel;
  AppGet authGet = Get.find();
  void onConnectionStateChange(ConnectionStateChange event) {
    print("23232323223 ${event.currentState}");
    if (event.currentState == 'CONNECTED') {
      print("connnnnecccccccccct");
    } else if (event.currentState == 'DISCONNECTED') {
      print("dddddddddddddddddddisconnnnnecccccccccct");
    }
  }

  FlutterPusher getPusherClient() {
    PusherOptions options = PusherOptions(
      host:
          'api.pythagorath.com/app/123?protocol=7&client=js&version=7.0.0&flash=false',
      port: 6001,
      cluster: null,
      encrypted: true,
    );
    return FlutterPusher(
      '123',
      options,
      lazyConnect: true,
      onConnectionStateChange: (v) {
        print("rrrrrrrrrrrrrrdddddddddddddddddddddddd $v");
      },
      onError: (ee) {
        print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb ${ee.exception}");
      },
    );
  }

  ini(BuildContext context) {
    pusherClient = getPusherClient();
    echo = new Echo({
      'broadcaster': 'pusher',
      'client': pusherClient,
    });

    print("1111111111111111111111111111111111111111111");
    pusherClient.connect(
      onConnectionStateChange: this.onConnectionStateChange,
      onError: (e) {
        print(
            "ttttttttttttttttttttttttttttttttttttttttttttttttttt ${e.exception}");
      },
    );
    print("111111111111111111111111111111111111111111122222222222222222222222");
    channel = echo.channel(channelName);

    channel.listen(event, (e) {
      print("rrrrrrrrrrrrrr ${e['notification']['description']}");

      NotificationHandler().showNotification(
          e['notification']['level_id'] == 0
              ? "جميع الصفوف"
              : e['notification']['level_id'] == 1
                  ? "الصف الخامس"
                  : e['notification']['level_id'] == 2
                      ? "الصف السادس"
                      : e['notification']['level_id'] == 3
                          ? "الصف السابع"
                          : e['notification']['level_id'] == 4
                              ? "الصف الثامن"
                              : e['notification']['level_id'] == 5
                                  ? "الصف التاسع"
                                  : e['notification']['level_id'] == 6
                                      ? "الصف العاشر"
                                      : e['notification']['level_id'] == 7
                                          ? "الصف الحادي عشر"
                                          : e['notification']['level_id'] == 8
                                              ? "الصف الثاني عشر"
                                              : "الصف الخامس",
          "${e['notification']['description']}");

      authGet.setCountNotifi(authGet.countNotificationfet + 1);
      // Future.delayed(Duration(milliseconds: 200), () async {
      //   int c1 = await SPHelper.spHelper.getCountNotification();
      //   Provider.of<AuthProviderUser>(context).setCountNotification(c1 + 1);
      // });
      Fluttertoast.showToast(
          msg: "${e['notification']['description']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void listenToChannel(String type, String name, String event) {
    // dynamic channel;

    // if (type == 'public') {
    //   channel = echo.channel(name);
    // } else if (type == 'private') {
    //   channel = echo.private(name);
    // } else if (type == 'presence') {
    //   channel = echo.join(name).here((users) {
    //     print(users);
    //   }).joining((user) {
    //     print(user);
    //   }).leaving((user) {
    //     print(user);
    //   });
    // }

    // channel.listen(event, (e) {
    //   print("rrrrrrrrrrrrrr ${e['notification']['description']}");

    // });
  }
}
