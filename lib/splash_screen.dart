import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/features/users/GetApp/app_get.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/repo/api_user_client.dart';
import 'package:pythagoras/features/users/ui/screens/home_screen.dart';
import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/images_name.dart';
import 'bloc/bloc_class.dart';
import 'bloc/bloc_states.dart';
import 'features/users/ui/screens/log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppGet authGet = Get.find();

  @override
  void initState() {
    // int blllo;
    super.initState();
    // Future.delayed(Duration(milliseconds: 200), () {
    //   blllo = authGet.blocked;
    //   print("++++++++++++++++++++++++++++++++++++++++ $blllo");
    // });

    Timer(Duration(seconds: 3), () async {
    BlocProvider.of<UserBloc>(context).add(SettingsEvent());

      // Map data1 = await ApiUserClient.apiUserClient.settingsUser();
      // authGet.setTerm(data1["term_enabled"]);
      String token = await SPHelper.spHelper.getToken();
      int bloked = await SPHelper.spHelper.getBlocked();
      print("rrrrrrrrrrrraaaaaaaaaaaammmmmmmmmmmm $token");
      if (token == null || token == '' || bloked == 1) {
        pushAndRemoveUntil(
          context,
          LogInScreen(),
        );
      } else {
        Timer(Duration(seconds: 3), () async {
          pushAndRemoveUntil(
            context,
            HomeScreen(),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(375, 812),
      allowFontScaling: true
    );

    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      bcksplash,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      forgroundsplash,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(
                    child: Container(
                      height: ScreenUtil().setHeight(175),
                      width: ScreenUtil().setWidth(145),
                      child: SvgPicture.asset(
                        logospalsh,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  BlocBuilder<UserBloc, BlocStates>(
                    builder: (context, state) {
                      if (state is TasksLoadingState) {
                        return Center(
                            //  child: CircularProgressIndicator(),
                            );
                      } else if (state is EmptyTasksState) {
                        return Center(
                            //  child: Text('Empty Tasks'),
                            );
                      } else if (state is TasksErrorState) {
                        return Center(
                            //  child: Text(state.error),
                            );
                      } else if (state is SettingsState) {
                        Map mySetting = state.data["setting"];

                        Provider.of<AuthProviderUser>(context)
                            .setInitialVideo(mySetting["guide_video_url"]);

                        Provider.of<AuthProviderUser>(context)
                            .settitlePay(mySetting["payment_guide_title"]);
                        Provider.of<AuthProviderUser>(context).setsubTitlePay(
                            mySetting["payment_guide_description"]);
                        Provider.of<AuthProviderUser>(context).settitleLive(
                            mySetting["online_videos_guide_title"]);
                        Provider.of<AuthProviderUser>(context).setsubTitleLive(
                            mySetting["online_videos_guide_description"]);

                        //dpush(context, LogInScreen());
                        return Container();
                      }
                      return Container();
                    },
                  )
                ],
              ))),
    );
  }
}
