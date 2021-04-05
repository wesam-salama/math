import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pythagoras/animate_do.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/features/users/ui/screens/classes_details.dart';
import 'package:pythagoras/features/users/ui/widgets/card_classes_years.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/styles.dart';

class ClassesYears extends StatelessWidget {
  String level;
  Color color;
  String mathType;

  ClassesYears({this.level, this.color, this.mathType});
 // int count2;

  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LevelsEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // print("object        $color");
    // int count = Provider.of<AuthProviderUser>(context).countNotificationSp;
    // if (Provider.of<AuthProviderUser>(context).countNotification == null) {
    //   count2 = 0;
    // } else {
    //   count2 = Provider.of<AuthProviderUser>(context).countNotification;
    // }

    // if (count2 > count) {
    //   Provider.of<AuthProviderUser>(context)
    //       .setCountNotification(count2 - count);
    // } else {
    //   Provider.of<AuthProviderUser>(context).setCountNotification(0);
    // }
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
       resizeToAvoidBottomInset: false,
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
            child: BlocBuilder<UserBloc, BlocStates>(
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
                  print("snnnnnnnnnnnnnnnnnnnn ${mySetting["term_enabled"]}");

                  return ListView(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "اختر الفصل الدراسي",
                          style: styleClassesYears,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      SlideInLeft(
                        animate: true,
                        duration: Duration(milliseconds: 1000),
                        child: mySetting["term_enabled"] == 0 ||
                                mySetting["term_enabled"] == 1
                            ? InkWell(
                                onTap: () {
                                  if (level == "7" || level == "8") {
                                    print(
                                        "leeeeeeeeبببببببببببببevel $level , $mathType");
                                    BlocProvider.of<UserBloc>(context).add(
                                        UnitTwilvEvent(level, mathType, "1"));
                                  } else {
                                    print("leeeeeeeeevel $level");
                                    BlocProvider.of<UserBloc>(context)
                                        .add(UnitEvent("1", level));
                                  }

                                  push(
                                      context,
                                      ClassesDetails(
                                        level: level,
                                        term: "1",
                                        color: color,
                                        mathType: mathType,
                                      ));
                                },
                                child: CardClassesYears(
                                  number: "01",
                                  title: "الفصل الدراسي الأول",
                                  color: color,
                                ),
                              )
                            : CardClassesYears(
                                number: "01",
                                title: " الفصل الأول غير مفعل",
                                color: Colors.grey,
                              ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      SlideInRight(
                        animate: true,
                        duration: Duration(milliseconds: 1000),
                        child: mySetting["term_enabled"] == 0 ||
                                mySetting["term_enabled"] == 2
                            ? InkWell(
                                onTap: () {
                                  if (level == "7" || level == "8") {
                                    print("leeeeeeeeevel $level");
                                    BlocProvider.of<UserBloc>(context).add(
                                        UnitTwilvEvent(level, mathType, "2"));
                                  } else {
                                    print("leeeeeeeeevel $level");
                                    BlocProvider.of<UserBloc>(context)
                                        .add(UnitEvent("2", level));
                                  }
                                  push(
                                      context,
                                      ClassesDetails(
                                        level: level,
                                        term: "2",
                                        color: color,
                                        mathType: mathType,
                                      ));
                                },
                                child: CardClassesYears(
                                  number: "02",
                                  title: "الفصل الدراسي الثاني",
                                  color: color,
                                ),
                              )
                            : CardClassesYears(
                                number: "02",
                                title: " الفصل الثاني غير مفعل",
                                color: Colors.grey,
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
                  );
                }
                return Container();
              },
            )),
      ),
    );
  }
}
