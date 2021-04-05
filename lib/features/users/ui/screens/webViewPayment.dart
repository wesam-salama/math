import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/features/users/ui/screens/watch_classes.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPayment extends StatefulWidget {
  var unitId;
  var level;
  var mathh;
  var term;
  WebViewPayment({this.unitId, this.level , this.mathh , this.term});
  @override
  _WebViewPaymentState createState() => _WebViewPaymentState();
}

class _WebViewPaymentState extends State<WebViewPayment> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(VideoEvent());
    // Navigator.popUntil(context, ModalRoute.withName('/WatchClasses'));
    pushReplecment(
        context,
        WatchClasses(
          level: widget.level,
          unitId: widget.unitId,
          mathType: widget.mathh,
          term: widget.term,
        ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Paypal"),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return isBob(context);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: BlocBuilder<UserBloc, BlocStates>(
            builder: (context, state) {
              if (state is TasksLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EmptyTasksState) {
                return Center(
                  child: Text('Empty Tasks'),
                );
              } else if (state is TasksErrorState) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is OrderPaymentState) {
                String redirect = state.redirect;
                print("ssssssssssssssssssssssssss $redirect");
                return WebView(
                  initialUrl: "$redirect",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
