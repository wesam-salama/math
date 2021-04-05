// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:overlay_support/overlay_support.dart';

// enum ConnectivityStatus { WiFi, Cellular, Offline }

// class ConnectivityService {
//   BuildContext context;
//   // Create our public controller

//   Stream<ConnectivityStatus> get valueStream =>
//       connectionStatusController.stream;
//   StreamController<ConnectivityStatus> connectionStatusController =
//       StreamController<ConnectivityStatus>();

//   ConnectivityService() {
//     // Subscribe to the connectivity Chanaged Steam
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       print(_getStatusFromResult(result));
//       connectionStatusController.add(_getStatusFromResult(result));
//       // if (_getStatusFromResult(result) == ConnectivityStatus.Offline) {
//       //   showOverlayNotification((context) {
//       //     this.context = context;

//       //     return Card(
//       //       color: Colors.red[800],
//       //       margin: const EdgeInsets.symmetric(horizontal: 4),
//       //       child: SafeArea(
//       //         child: Container(
//       //           width: double.infinity,
//       //           height: ScreenUtil().setHeight(50),
//       //           child: ListTile(
//       //             leading: Icon(
//       //               Icons.signal_wifi_off,
//       //               color: Colors.white,
//       //             ),
//       //             title: Text(
//       //               'connection_error',
//       //               style: TextStyle(color: Colors.white),
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //   }, duration: Duration(hours: 4000));
//       //   // Provider.of<AuthProvider>(context, listen: false)
//       //   //     .setIsEditProfile(false);
//       //   // Provider.of<ProductProvider>(context, listen: false)
//       //   //     .setIsInternetAdd(false);

//       //   // Provider.of<AuthProvider>(context, listen: false)
//       //   //     .setisChangePassword(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setIsCheckCode(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setisSendCode(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setgoToSignUp(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setisSignUp(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setIsLogin(false);
//       // } else if (_getStatusFromResult(result) != ConnectivityStatus.Offline &&
//       //     this.context != null) {
//       //   // Provider.of<ProductProvider>(context, listen: false)
//       //   //     .setIsInternetAdd(false);
//       //   // Provider.of<AuthProvider>(context, listen: false)
//       //   //     .setIsEditProfile(false);
//       //   // Provider.of<AuthProvider>(context, listen: false)
//       //   //     .setisChangePassword(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setIsCheckCode(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setisSendCode(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setgoToSignUp(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setisSignUp(false);
//       //   // Provider.of<AuthProvider>(context, listen: false).setIsLogin(false);
//       //   OverlaySupportEntry.of(context).dismiss();
//       // }
//       // else
//       // if (_getStatusFromResult(result) == ConnectivityStatus.WiFi) {
//       //   print("8888888888888888888888888888888888888uuuuuuuuuuuuuuuuuuuuu");
//       //   OverlaySupportEntry.of(context).dismiss();
//       // }
//     });
//   }
//   ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
//     switch (result) {
//       case ConnectivityResult.mobile:
//         return ConnectivityStatus.Cellular;
//       case ConnectivityResult.wifi:
//         return ConnectivityStatus.WiFi;
//       case ConnectivityResult.none:
//         return ConnectivityStatus.Offline;
//       default:
//         return ConnectivityStatus.Offline;
//     }
//   }
// }
