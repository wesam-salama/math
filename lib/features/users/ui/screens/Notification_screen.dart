import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/components/models/notification_model.dart';
import 'package:pythagoras/features/users/GetApp/app_get.dart';
import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/shadows.dart';
import 'package:pythagoras/values/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  String levelId;
  NotificationScreen({this.levelId});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(NotificationEvent());
    super.initState();
  }

  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LevelsEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    AppGet authGet = Get.find();
    return WillPopScope(
      onWillPop: () async {
        return isBob(context);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            // resizeToAvoidBottomPadding: false,
            backgroundColor: whiteColor,
            appBar: AppBar(
              title: Text(
                "الإشعارات",
                style: styleTitlePayment,
              ),
              backgroundColor: orangeColor,
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.all(20),
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
                  } else if (state is NotificationState) {
                    Notification1 notification = state.notification1;
                    List<DataNotification> myNotification = notification.data;

                    SPHelper.spHelper
                        .setCountNotification(myNotification.length);
                    Future.delayed(Duration(milliseconds: 500), () {
                      authGet.setCountNotifiSp(myNotification.length);
                    });

                    print(
                        "ccccccccvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv ${myNotification.length}");
                    return ListView.builder(
                      itemCount: myNotification.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            if (myNotification[index].link != null ||
                                myNotification[index].link != "") {
                              var url = "${myNotification[index].link}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                margin: EdgeInsets.only(bottom: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: borderRadius8,
                                    color: pinkColor,
                                    boxShadow: <BoxShadow>[boxShadow6]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myNotification[index].description,
                                      style: styleNotificationTitle,
                                    ),
                                    myNotification[index].link != null
                                        ? Text(
                                            myNotification[index].link,
                                            style: styleNotificationTitle,
                                          )
                                        : Text(""),
                                    Text(
                                      myNotification[index].createdAt,
                                      style: styleNotificationSubTitle,
                                    )
                                  ],
                                ),
                              ),
                              Transform.translate(
                                  offset: Offset(15, -20),
                                  child: SvgPicture.asset(
                                    lighticon,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            )),
      ),
    );
  }
}
