import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/ui/widgets/card_title_man.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_bottom.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/images_name.dart';

class VerificationPhoneScreen extends StatefulWidget {
  @override
  _VerificationPhoneScreenState createState() =>
      _VerificationPhoneScreenState();
}

class _VerificationPhoneScreenState extends State<VerificationPhoneScreen> {
  StreamController<ErrorAnimationType> errorController;
  TextEditingController textEditingController = TextEditingController();
  String currentText;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    // textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProviderUserWithListen = Provider.of<AuthProviderUser>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              height: ScreenUtil().setHeight(200),
              width: double.infinity,
              child: CardTitleMan(
                  title: Provider.of<AuthProviderUser>(context).titlePay,
                  subTitle1: Provider.of<AuthProviderUser>(context).subTitlePay,
                  subTitle2: Provider.of<AuthProviderUser>(context).subTitlePay,
                  color: blueColor),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              width: ScreenUtil().setWidth(280),
              child: PinCodeTextField(
                appContext: context,
                length: 5,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  activeColor: blueColor,
                  disabledColor: orangeColor,
                  inactiveColor: orangeColor,
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: false,
                errorAnimationController: errorController,
                controller: textEditingController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                    print(
                        "hhhhhhhhhhhhhhhhhhhhyyyyyyyyyyyyyyyyyyyy  $currentText");
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              child: CustomBottom(
                title: "تحقق",
                color: orangeColor,
                route: () {
                  BlocProvider.of<UserBloc>(context).add(
                      ResetPasswordConfirmEvent(
                          authProviderUserWithListen.mobile,
                          currentText,
                          context));
                },
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(150),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: ScreenUtil().setHeight(140),
                    width: double.infinity,
                    child: Image.asset(
                      imagebottom,
                      fit: BoxFit.fill,
                    ))),
          ],
        ),
      )),
    );
  }
}
