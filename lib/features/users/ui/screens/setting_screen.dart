import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/components/models/me_user.dart';
import 'package:pythagoras/features/users/ui/screens/about_me.dart';
import 'package:pythagoras/features/users/ui/screens/contact_us.dart';
import 'package:pythagoras/features/users/ui/screens/edit_profile.dart';
import 'package:pythagoras/features/users/ui/screens/log_in_screen.dart';
import 'package:pythagoras/features/users/ui/widgets/card_contact_us-dialog.dart';
import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/shadows.dart';
import 'package:pythagoras/values/styles.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LevelsEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(MeUserEvent());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: false,
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            "الإعدادات",
            style: styleTitlePayment,
          ),
          backgroundColor: orangeColor,
        ),
        body: WillPopScope(
          onWillPop: () async {
            return isBob(context);
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(10),
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
                } else if (state is MeUserState) {
                  MeUser myUser = state.meUser;

                  print("yyuyuyuyuuuuuuuuuuuuuuuuyuyuyuuyyuyu ${myUser.name}");
                  print(
                      "yyuyuyuyuuuuuuuuuuuuuuuuyuyuyuuyyuyu ${myUser.avatar}");

                  return Column(
                    children: [
                      //SizedBox(height: ScreenUtil().setHeight(20),),

                      Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(130),
                        decoration: BoxDecoration(
                            color: blueColor, borderRadius: borderRadius5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            myUser.avatar == null || myUser.avatar == ""
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundColor: whiteColor,
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 60,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage: CachedNetworkImageProvider(
                                        "${myUser.avatar}"),
                                  ),
                            Container(
                              width: ScreenUtil().setWidth(135),
                              height: ScreenUtil().setHeight(85),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myUser.name,
                                    style: styleSettingName,
                                  ),
                                  Text(
                                    myUser.location,
                                    style: styleSettingPhone,
                                  ),
                                  Text(
                                    myUser.phone,
                                    style: styleSettingPhone,
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          EditProfile(
                                              name: myUser.name,
                                              mobile: myUser.phone,
                                              location: myUser.location,
                                              supervisor: myUser.supervisor,
                                              supervisorType:
                                                  myUser.supervisorType,
                                              gender: myUser.gender,
                                              levelId: myUser.levelId));
                                    },
                                    child: Text(
                                      "تحديث",
                                      style: styleSettingName,
                                    )),
                                Container(
                                  width: ScreenUtil().setWidth(120),
                                  height: ScreenUtil().setHeight(100),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(profile),
                                          fit: BoxFit.fill)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),

                      Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(280),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: borderRadius8,
                            boxShadow: <BoxShadow>[boxShadow6]),
                        child: Column(
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(40),
                              child: ListTile(
                                onTap: () {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CardContactUsDialog();
                                    },
                                  );
                                },
                                leading: Icon(
                                  Icons.bookmark,
                                  color: blueColor,
                                  size: 20,
                                ),
                                title: Text(
                                  "هل أنت معلم وتود الإنضمام لنا  ؟",
                                  style: styleSettingTitle,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                              ),
                            ),
                            Divider(),
                            Container(
                              height: ScreenUtil().setHeight(40),
                              child: ListTile(
                                onTap: () {
                                  push(context, ContactUs());
                                },
                                leading: Icon(
                                  Icons.phone,
                                  color: blueColor,
                                  size: 20,
                                ),
                                title: Text(
                                  "تواصل معنا",
                                  style: styleSettingTitle,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                              ),
                            ),
                            Divider(),
                            Container(
                              height: ScreenUtil().setHeight(40),
                              child: ListTile(
                                onTap: () {
                                  push(context, AboutMe());
                                },
                                leading: Icon(
                                  Icons.info,
                                  color: blueColor,
                                  size: 20,
                                ),
                                title: Text(
                                  "من نحن",
                                  style: styleSettingTitle,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                              ),
                            ),
                            Divider(),
                            InkWell(
                              onTap: () {
                                SPHelper.spHelper.setToken(null);
                                pushAndRemoveUntil(context, LogInScreen());
                              },
                              child: Container(
                                  height: ScreenUtil().setHeight(40),
                                  width: ScreenUtil().setWidth(100),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.exit_to_app,
                                        color: blueColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setHeight(10),
                                      ),
                                      Text(
                                        "تسجيل خروج",
                                        style: styleSettingTitle,
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
