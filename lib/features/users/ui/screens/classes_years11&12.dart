import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pythagoras/animate_do.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/features/users/ui/screens/classes_years.dart';
import 'package:pythagoras/features/users/ui/widgets/card_classes_years.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/styles.dart';

class ClassesYears2 extends StatelessWidget {
  String level;
  Color color;

  ClassesYears2({this.level, this.color});
  int count2;

  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LevelsEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print("object        $color");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color,
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
          margin: EdgeInsets.all(30),
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "اختر القسم",
                  style: styleClassesYears,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              SlideInLeft(
                animate: true,
                duration: Duration(milliseconds: 1000),
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<UserBloc>(context).add(SettingsEvent());
                    // print("leeeeeeeeevel $level");
                    // BlocProvider.of<UserBloc>(context)
                    //     .add(UnitEvent("1", level));
                    push(
                        context,
                        ClassesYears(
                          color: color,
                          level: level,
                          mathType: "app",
                        ));
                  },
                  child: CardClassesYears(
                    number: "01",
                    title: "التطبيقية",
                    color: color,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              SlideInRight(
                animate: true,
                duration: Duration(milliseconds: 1000),
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<UserBloc>(context).add(SettingsEvent());

                    push(
                        context,
                        ClassesYears(
                          color: color,
                          level: level,
                          mathType: "pure",
                        ));
                  },
                  child: CardClassesYears(
                    number: "02",
                    title: "البحتة",
                    color: color,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(70),
              ),
              Container(
                height: ScreenUtil().setHeight(252),
                width: ScreenUtil().setWidth(352),
                child: SvgPicture.asset(
                  classes,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "متعة تعلم الرياضيات",
                  style: styleTitleButClassesYears,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
