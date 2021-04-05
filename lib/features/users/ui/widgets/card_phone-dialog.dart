import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/animate_do.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_Text_Field.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/styles.dart';

class CardPhoneDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProviderUserWithListen = Provider.of<AuthProviderUser>(context);

    return ZoomIn(
      animate: true,
      duration: Duration(milliseconds: 1000),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: borderRadius8),
        child: Container(
          height: ScreenUtil().setHeight(315),
          width: ScreenUtil().setWidth(267),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: orangeColor,
                radius: 35,
                child: Icon(
                  Icons.phone,
                  color: whiteColor,
                  size: 40,
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "أدخل رقم الهاتف وسيتم إرسال لك",
                    style: styleSubTitleBlue,
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "رسالة نصية",
                    style: styleSubTitleBlue,
                  )),
              Container(
                  width: ScreenUtil().setWidth(237),
                  child: CustomTextField(
                    hintTitle: "رقم الهاتف",
                    icon: Icon(
                      Icons.phone,
                      size: 20,
                    ),
                    onSaved: authProviderUserWithListen.setMobile,
                  )),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  if (authProviderUserWithListen.mobile != null) {
                    BlocProvider.of<UserBloc>(context).add(
                        ResetEvent(authProviderUserWithListen.mobile, context));
                  } else {
                    Fluttertoast.showToast(
                        msg: "رقم الهاتف غير صحيحة",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "حسنا",
                    style: styleButtomDialog,
                  ),
                ),
              )
            ],
          ),
        ),
        //this right here
      ),
    );
  }
}
