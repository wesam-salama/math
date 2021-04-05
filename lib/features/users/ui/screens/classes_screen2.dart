import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/components/models/levels.dart';
import 'package:pythagoras/components/models/video.dart';
import 'package:pythagoras/features/users/GetApp/app_get.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/providers/user_provider.dart';
import 'package:pythagoras/features/users/ui/screens/Notification_screen.dart';
import 'package:pythagoras/features/users/ui/screens/classes_years.dart';
import 'package:pythagoras/features/users/ui/screens/classes_years11&12.dart';
import 'package:pythagoras/features/users/ui/screens/home_screen.dart';
import 'package:pythagoras/features/users/ui/screens/live_screen.dart';
import 'package:pythagoras/features/users/ui/screens/setting_screen.dart';
import 'package:pythagoras/features/users/ui/screens/watch_classes2.dart';
import 'package:pythagoras/features/users/ui/widgets/card_clasess2.dart';
import 'package:pythagoras/features/users/ui/widgets/card_search.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/styles.dart';

class ClassesScreen2 extends StatefulWidget {
  @override
  _ClassesScreen2State createState() => _ClassesScreen2State();
}

class _ClassesScreen2State extends State<ClassesScreen2> {
  AppGet authGet = Get.find();
  int count2;
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(LevelsEvent());

    super.initState();
  }

  isBob(BuildContext context) {
    pushAndRemoveUntil(context, HomeScreen());
    return true;
  }

  String search = "";
  @override
  Widget build(BuildContext context) {
    int count = Provider.of<AuthProviderUser>(context).countNotificationSp;
    if (Provider.of<AuthProviderUser>(context).countNotification == 0) {
      count2 = 0;
    } else {
      count2 = Provider.of<AuthProviderUser>(context).countNotification;
    }

    if (count2 > count) {
      Provider.of<AuthProviderUser>(context)
          .setCountNotification(count2 - count);
    } else {
      Provider.of<AuthProviderUser>(context).setCountNotification(0);
    }
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(MeUserEvent());
                push(context, SettingScreen());
              }),
        ],
        leading: InkWell(
          onTap: () {
            BlocProvider.of<UserBloc>(context).add(NotificationEvent());
            authGet.setCountNotifi(0);
            push(
                context,
                NotificationScreen(
                    // levelId: "0",
                    ));
          },
          child: GetBuilder<AppGet>(
              id: 'notifi',
              builder: (controller) {
                return Badge(
                  // padding: EdgeInsets.all(10),
                  position: BadgePosition(top: 1, end: 1),
                  badgeContent:
                      Text(controller.countNotificationfet.toString()),
                  child: Icon(
                    Icons.notifications,
                    size: 25,
                    color: whiteColor,
                  ),
                );
              }),
        ),
        backgroundColor: orangeColor,
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
        child: ListView(
          children: [
            Container(
              height: ScreenUtil().setHeight(50),
              width: double.infinity,
              decoration:
                  BoxDecoration(color: orangeColor, boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 6,
                    color: blackColor.withOpacity(.16),
                    offset: Offset(0, 3))
              ]),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(6)),
                height: ScreenUtil().setHeight(45),
                width: ScreenUtil().setWidth(315),
                decoration: BoxDecoration(
                    borderRadius: borderRadius22, color: whiteColor),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value != null || value != "") {
                        BlocProvider.of<UserBloc>(context).add(VideoEvent());
                      } else {
                        BlocProvider.of<UserBloc>(context).add(LevelsEvent());
                      }

                      search = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 12),
                        border: InputBorder.none,
                        hintText: "بحث",
                        hintStyle: styleTextFieldLogIn,
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            search == null || search == ""
                ? Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    height: ScreenUtil().setHeight(665),
                    width: double.infinity,
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
                        } else if (state is LevelsState) {
                          List<LevelsData> dataLevels = state.data;
                          List<LevelsData> dataLevels2 =
                              dataLevels.reversed.toList();

                          return ListView.builder(
                            itemCount: dataLevels.length,
                            itemBuilder: (context, index) {
                              return Container(
                                //color: Colors.amber,
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<UserBloc>(context)
                                        .add(SettingsEvent());
                                    if (index == 6 || index == 7) {
                                      push(
                                          context,
                                          ClassesYears2(
                                            level: dataLevels2[index]
                                                .id
                                                .toString(),
                                            color: index == 0
                                                ? color5
                                                : index == 1
                                                    ? color6
                                                    : index == 2
                                                        ? color7
                                                        : index == 3
                                                            ? color8
                                                            : index == 4
                                                                ? color9
                                                                : index == 5
                                                                    ? color10
                                                                    : index == 6
                                                                        ? color11
                                                                        : index ==
                                                                                7
                                                                            ? color12
                                                                            : color12,
                                          ));
                                    } else {
                                      push(
                                          context,
                                          ClassesYears(
                                            level: dataLevels2[index]
                                                .id
                                                .toString(),
                                            color: index == 0
                                                ? color5
                                                : index == 1
                                                    ? color6
                                                    : index == 2
                                                        ? color7
                                                        : index == 3
                                                            ? color8
                                                            : index == 4
                                                                ? color9
                                                                : index == 5
                                                                    ? color10
                                                                    : index == 6
                                                                        ? color11
                                                                        : index ==
                                                                                7
                                                                            ? color12
                                                                            : color12,
                                          ));
                                    }
                                  },
                                  child: YearListAddress(
                                    index: index,
                                    dataLevel: dataLevels.reversed.toList(),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: ScreenUtil().setHeight(665),
                      width: double.infinity,
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
                          } else if (state is VideoState) {
                            List<VideoData> allVideo = state.data;
                            // List<VideoData> searchVideo1;
                            // int termn = authGet.term;
                            // if (termn == 0) {
                            //   searchVideo1 = allVideo;
                            // }else if(termn == 1){
                            //   searchVideo1 =  allVideo
                            //     .where(
                            //         (element) => element.)
                            //     .toList();

                            // }else if(termn == 2){

                            // }else{

                            // }
                            List<VideoData> searchVideo = allVideo
                                .where(
                                    (element) => element.title.contains(search))
                                .toList();

                            return ListView.builder(
                              itemCount: searchVideo.length,
                              itemBuilder: (context, index) {
                                //    print(
                                //  "sssssddddddcccccccccccccccccccc ${searchVideo[index].title}");
                                return InkWell(
                                  onTap: () {
                                    if (searchVideo[index].type == "OFFLINE") {
                                      BlocProvider.of<UserBloc>(this.context)
                                          .add(IsAccessVideoEvent(
                                              searchVideo[index].id.toString(),
                                              this.context,
                                              WatchClasses2(
                                                unitId:
                                                    searchVideo[index].unitId,
                                                level: searchVideo[index]
                                                    .levelId
                                                    .toString(),
                                                term: searchVideo[index]
                                                    .unit
                                                    .term
                                                    .toString(),
                                                videoUrl:
                                                    "${searchVideo[index].videoAccessUrl}",
                                                color: pinkColor,
                                                title: "الدرس ${index + 1}",
                                                desTitle:
                                                    searchVideo[index].title,
                                                price: double.parse(
                                                    "${searchVideo[index].unit.price}"),
                                              ),
                                              searchVideo[index].unitId,
                                              searchVideo[index]
                                                  .levelId
                                                  .toString(),
                                              double.parse(
                                                  "${searchVideo[index].unit.price}")));
                                    } else {
                                      // BlocProvider.of<UserBloc>(this.context).add(
                                      //     UnitEvent(widget.term, widget.level));
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .getVideoAccess(
                                              searchVideo[index].id.toString());
                                      Future.delayed(Duration(seconds: 1), () {
                                        return BlocProvider.of<UserBloc>(
                                                this.context)
                                            .add(IsAccessVideoEvent(
                                                searchVideo[index]
                                                    .id
                                                    .toString(),
                                                this.context,
                                                LiveScreen(
                                                  linkLive:
                                                      Provider.of<UserProvider>(
                                                              context,
                                                              listen: false)
                                                          .link,
                                                  level: searchVideo[index]
                                                      .levelId
                                                      .toString(),
                                                  term: searchVideo[index]
                                                      .unit
                                                      .term
                                                      .toString(),
                                                  color: pinkColor,
                                                ),
                                                searchVideo[index].unitId,
                                                searchVideo[index]
                                                    .levelId
                                                    .toString(),
                                                double.parse(
                                                    "${searchVideo[index].unit.price}")));
                                      });

                                      // }

                                    }
                                  },
                                  child: CardSearch(
                                    myVideo: searchVideo[index],
                                  ),
                                );
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
