import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/styles.dart';

class LiveScreen extends StatefulWidget {
  var linkLive;
  var level;
  var term;
  Color color;
  LiveScreen({this.linkLive, this.level, this.term, this.color});
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  InAppWebViewController webViewController;

  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(VideoEvent());
    return true;
  }

  String finalV = '';

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("rmxiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii ${widget.linkLive}");

    BlocProvider.of<UserBloc>(context)
        .add(UnitEvent(widget.term, widget.level));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.color,
        title: Column(
          children: [
            Image.asset(
              'assets/images/qwd.png',
              fit: BoxFit.fill,
              height: 30,
            ),
            Text("متعة تعلم الرياضيات", style: styleSubLogoLight),
          ],
        ),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return isBob(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: widget.linkLive != null || widget.linkLive != ""
              ? Container(
                  decoration: BoxDecoration(borderRadius: borderRadius8),
                  height: ScreenUtil().setHeight(400),
                  width: ScreenUtil().setWidth(332),
                  child: InAppWebView(
                    initialData: InAppWebViewInitialData(
                      data: """${widget.linkLive}""",
                    ),
                    initialHeaders: {},
                    androidOnPermissionRequest:
                        (InAppWebViewController controller, String origin,
                            List<String> resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            debuggingEnabled: true,
                            userAgent:
                                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",
                            mediaPlaybackRequiresUserGesture: true)),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webViewController = controller;
                    },
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      if (url.contains("bigbluebutton")) {
                        controller.goBack();
                        Fluttertoast.showToast(
                            msg: "هذه الميزة غير متاحة لك",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) {},
                    onConsoleMessage: (InAppWebViewController controller,
                        ConsoleMessage consoleMessage) {
                      print("console message: ${consoleMessage.message}");
                    },
                  ),
                )
              : Container(
                  child: Center(
                    child: Text("No Video"),
                  ),
                ),
        ),
      ),
    );
  }
}
