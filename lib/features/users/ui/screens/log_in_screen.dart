import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/animate_do.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/features/users/GetApp/app_get.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/ui/screens/sign_up_screen.dart';
import 'package:pythagoras/features/users/ui/widgets/card_phone-dialog.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_Text_Field.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_bottom.dart';
import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/styles.dart';

class LogInScreen extends StatelessWidget {
  final GlobalKey<FormState> loginFormkey =
      GlobalKey<FormState>(debugLabel: '_loginFormKey');
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "اضغط مره اخرى للخروج",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: orangeColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    AppGet authGet = Get.find();
    final authProviderUserWithListen = Provider.of<AuthProviderUser>(context);
    final authProviderUserNoListen =
        Provider.of<AuthProviderUser>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: false,
        backgroundColor: whiteColor,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Stack(
            children: [
              FadeIn(
                animate: true,
                duration: Duration(milliseconds: 1000),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: ScreenUtil().setHeight(350),
                      width: double.infinity,
                      child: SvgPicture.asset(
                        backgroundlogin,
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Transform.translate(
                offset: Offset(0, 150),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "مرحبا بك",
                        style: styleTitleLogIn,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                          key: loginFormkey,
                          child: Column(
                            children: [
                              SlideInUp(
                                animate: true,
                                duration: Duration(milliseconds: 1000),
                                child: CustomTextField(
                                  keyboardType: TextInputType.number,
                                  hintTitle: "رقم الهاتف",
                                  icon: Icon(
                                    Icons.phone,
                                    size: 20,
                                  ),
                                  onSaved: authProviderUserWithListen.setMobile,
                                  onValidate:
                                      authProviderUserWithListen.validateMobile,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              SlideInUp(
                                animate: true,
                                duration: Duration(milliseconds: 1300),
                                child: CustomTextField(
                                  hintTitle: "كلمة السر",
                                  icon: Icon(
                                    Icons.lock,
                                    size: 20,
                                  ),
                                  onSaved:
                                      authProviderUserWithListen.setPassword,
                                  onValidate: authProviderUserWithListen
                                      .validatePassword,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              SlideInUp(
                                animate: true,
                                duration: Duration(milliseconds: 1600),
                                child: InkWell(
                                  onTap: () {
                                    authProviderUserWithListen.setMobile(null);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CardPhoneDialog();
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(50)),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "نسيت كلمة السر؟",
                                        style: styleForgetPassLogIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(30),
                              ),
                              SlideInUp(
                                animate: true,
                                duration: Duration(milliseconds: 1900),
                                child: CustomBottom(
                                  title: "تسجيل دخول",
                                  color: orangeColor,
                                  route: () {
                                    authProviderUserNoListen.onSavedLoginForm(
                                        context, loginFormkey);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              SlideInUp(
                                animate: true,
                                duration: Duration(milliseconds: 2200),
                                child: InkWell(
                                  onTap: () {
                                    authProviderUserWithListen
                                        .setImageProfile(null);
                                    push(context, SignUpScreen());
                                  },
                                  child: Container(
                                    width: ScreenUtil().setWidth(262),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                          "قم بإنشاء حساب",
                                          style: styleTextFieldLogIn.copyWith(
                                              color: orangeColor),
                                        ),
                                        Text(
                                          "ليس لديك حساب ؟ ",
                                          style: styleTextFieldLogIn,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(50),
                                child: BlocBuilder<UserBloc, BlocStates>(
                                  builder: (context, state) {
                                    if (state is TasksLoadingState) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is EmptyTasksState) {
                                      return Center(
                                          // child: Text('Empty Tasks'),
                                          );
                                    } else if (state is TasksErrorState) {
                                      return Container();
                                    } else if (state is UserLogedInState) {
                                      String tok = state.token;
                                      print(
                                          "yyuyuyuyuuuuuuuuuuuuuuuuyuyuyuuyyuyu $tok");
                                      SPHelper.spHelper.setToken(tok);
                                      BlocProvider.of<UserBloc>(context)
                                          .add(SettingsEvent());

                                      //push(context, HomeScreen());
                                      return Center();
                                    }
                                    if (state is SettingsState) {
                                      Map mySetting = state.data["setting"];

                                      Provider.of<AuthProviderUser>(context)
                                          .setInitialVideo(
                                              mySetting["guide_video_url"]);

                                      Provider.of<AuthProviderUser>(context)
                                          .settitlePay(
                                              mySetting["payment_guide_title"]);
                                      Provider.of<AuthProviderUser>(context)
                                          .setsubTitlePay(mySetting[
                                              "payment_guide_description"]);
                                      Provider.of<AuthProviderUser>(context)
                                          .settitleLive(mySetting[
                                              "online_videos_guide_title"]);
                                      Provider.of<AuthProviderUser>(context)
                                          .setsubTitleLive(mySetting[
                                              "online_videos_guide_description"]);
                                      //  Timer(Duration(seconds: 2), () async {

                                      BlocProvider.of<UserBloc>(context)
                                          .add(MeStatusEvent(context));

                                      return Container();
                                    }

                                    if (state is MeStatusState) {
                                      int phoneV = state.phoneVerified;
                                      Future.delayed(
                                          Duration(milliseconds: 100), () {
                                        authGet.setBolcked(state.blocked);
                                        SPHelper.spHelper
                                            .setBlocked(state.blocked);
                                        print(
                                            "888888888888888888888888 ${state.blocked}");
                                      });
                                      print(
                                          "555555555555555555555555555555555555");
                                      Provider.of<AuthProviderUser>(context)
                                          .setPhoneVerified(phoneV);
                                    }

                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: ScreenUtil().setHeight(1.15),
                        // widthFactor: 1.9,
                        child: Container(
                            //flutt color: pinkColor,
                            height: ScreenUtil().setHeight(170),
                            width: ScreenUtil().setWidth(180),
                            //color: orangeColor,
                            child: Image.asset(
                              loginBoutom0,
                              fit: BoxFit.fill,
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
