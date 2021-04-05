import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/animate_do.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_Text_Field.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_bottom.dart';
import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/styles.dart';

class UpdatePassword extends StatelessWidget {
  final GlobalKey<FormState> loginFormkey =
      GlobalKey<FormState>(debugLabel: '_loginFormKey');

  @override
  Widget build(BuildContext context) {
    final authProviderUserWithListen = Provider.of<AuthProviderUser>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: false,
        backgroundColor: whiteColor,
        body: Stack(
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
                      "تعديل كلمة المرور",
                      style: styleTitleLogIn.copyWith(fontSize: 35),
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
                                hintTitle: "كلمة  السر الجديدة",
                                icon: Icon(
                                  Icons.lock,
                                  size: 20,
                                ),
                                onSaved: authProviderUserWithListen.setPassword,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(15),
                            ),
                            SlideInUp(
                              animate: true,
                              duration: Duration(milliseconds: 1300),
                              child: CustomTextField(
                                  hintTitle: "تاكيد كلمة السر",
                                  icon: Icon(
                                    Icons.lock,
                                    size: 20,
                                  ),
                                  onSaved: authProviderUserWithListen
                                      .setConfirmPassword),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            SlideInUp(
                              animate: true,
                              duration: Duration(milliseconds: 1900),
                              child: CustomBottom(
                                title: "تغيير كلمة المرور",
                                color: orangeColor,
                                route: () async {
                                  String token1 =
                                      await SPHelper.spHelper.getToken();
                                  BlocProvider.of<UserBloc>(context).add(
                                      ResetPasswordConfirmUpdateEvent(
                                          authProviderUserWithListen.mobile,
                                          token1,
                                          authProviderUserWithListen
                                              .confirmPassword,
                                          context));
                                },
                              ),
                            ),
                            Container(
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
                                    return Center(
                                      child: Text(state.error),
                                    );
                                  } else if (state
                                      is ResetPasswordConfirmState) {
                                    String tok = state.token;
                                    print(
                                        "yyuyuyuyuuuuuuuuuuuuuuuuyuyuyuuyyuyu $tok");
                                    SPHelper.spHelper.setToken(tok);

                                    //push(context, HomeScreen());
                                    return Center();
                                  }
                                  if (state
                                      is ResetPasswordConfirmUpdateState) {
                                    //  pushAndRemoveUntil(context, LogInScreen());
                                    return Container();
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
