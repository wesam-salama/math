// import 'dart:async';

// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pythagoras/services/socket_class.dart';

// class CheckInternet {
//   StreamSubscription<DataConnectionStatus> listener;
//   var internetStatus = "Unknown";
//   var contentmessage = "Unknown";

//   void _showDialog(String title, String content, BuildContext context,
//       Color color, Duration duration) {
//     print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj $content");

//     Fluttertoast.showToast(
//       msg: content,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: color,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );

//     // showOverlayNotification((context) {
//     //   //  this.context = context;

//     //   return Card(
//     //     color: color,
//     //     margin: const EdgeInsets.symmetric(horizontal: 4),
//     //     child: SafeArea(
//     //       child: Container(
//     //         width: double.infinity,
//     //         height: ScreenUtil().setHeight(50),
//     //         child: ListTile(
//     //           leading: Icon(
//     //             Icons.signal_wifi_off,
//     //             color: Colors.white,
//     //           ),
//     //           title: Text(
//     //             content,
//     //             style: TextStyle(color:Colors.white),
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   );
//     // }, duration: duration);

//     // showDialog(
//     //     context: context,
//     //     builder: (BuildContext context) {
//     //       return AlertDialog(
//     //           title: new Text("error"),
//     //           content: new Text(content),
//     //           actions: <Widget>[
//     //             new FlatButton(
//     //                 onPressed: () {
//     //                   Navigator.of(context).pop();
//     //                 },
//     //                 child: new Text("Close"))
//     //           ]);
//     //     });
//   }

//   checkConnection(BuildContext context) async {
//     try {
//       listener = DataConnectionChecker().onStatusChange.listen((status) {
//         switch (status) {
//           case DataConnectionStatus.connected:
//             //Navigator.of(context).pop();
//             //   OverlaySupportEntry.of(context).dismiss();
            
//            // SocketHandel().pusherClient.disconnect();
//             internetStatus = "Connected to the Internet";
//             contentmessage = "Connected to the Internet";
//             _showDialog(internetStatus, "متصل بالانترنت", context, Colors.green,
//                 Duration(seconds: 3));
//             break;
//           case DataConnectionStatus.disconnected:
//             internetStatus = "You are disconnected to the Internet. ";
//             contentmessage = "Please check your internet connection";
//             _showDialog(
//                 internetStatus,
//                 "غير متصل بالانترنت , جاري الاتصال",
//                 context,
//                 Colors.red,
//                 status == DataConnectionStatus.connected
//                     ? Duration(hours: 0)
//                     : Duration(hours: 3));
//             break;
//         }
//       });

//       return await DataConnectionChecker().connectionStatus;
//     } catch (e) {
//       print(e);
//     }
//   }
// }
