import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pythagoras/animate_do.dart';
import 'package:pythagoras/components/models/levels.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/shadows.dart';
import 'package:pythagoras/values/styles.dart';

class CardClasess extends StatelessWidget {
  int index;
  List<LevelsData> dataLevel;
  CardClasess({this.index, this.dataLevel});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SlideInUp(
        animate: true,
        duration: Duration(milliseconds: 1000),
        child: Container(
          height: ScreenUtil().setHeight(165),
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: index == 5 || index == 6 || index == 7
                        ? ScreenUtil().setWidth(80)
                        : ScreenUtil().setWidth(1)),
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(21),
                  top: ScreenUtil().setHeight(3),
                  bottom: ScreenUtil().setHeight(4),
                ),
                width: double.infinity,
                height: index == 5 || index == 6 || index == 7
                    ? ScreenUtil().setHeight(170)
                    : ScreenUtil().setHeight(130),
                decoration: BoxDecoration(
                    color: index == 0
                        ? pinkColor
                        : index == 1
                            ? green6
                            : index == 2
                                ? blue7
                                : index == 3
                                    ? color888
                                    : index == 4
                                        ? color999
                                        : index == 5
                                            ? pinkColor
                                            : index == 6
                                                ? color888
                                                : index == 7
                                                    ? green6
                                                    : pinkColor,
                    borderRadius: borderRadius8),
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              dataLevel[index].name,
                              style: styleTitleCardClasses,
                            )),
                      ),
                      Text(
                        "${dataLevel[index].usersCount} طالب مسجل",
                        style: styleSubTitleCardClasses,
                      ),
                      Divider(
                        color: whiteColor,
                        thickness: 1,
                        endIndent: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: ScreenUtil().setHeight(32),
                          width: ScreenUtil().setWidth(220),
                          child: Text(
                            dataLevel[index].description,
                            textAlign: TextAlign.end,
                            style: styleSubTitleCardClasses,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(0, ScreenUtil().setHeight(30)),
                    child: index == 0
                        ? Text(
                            "5",
                            style: styleNumberCardClasses,
                          )
                        : index == 1
                            ? Text(
                                "6",
                                style: styleNumberCardClasses.copyWith(
                                    color: green6),
                              )
                            : index == 2
                                ? Text(
                                    "7",
                                    style: styleNumberCardClasses.copyWith(
                                        color: blue7),
                                  )
                                : index == 3
                                    ? Text(
                                        "8",
                                        style: styleNumberCardClasses.copyWith(
                                            color: color888),
                                      )
                                    : index == 4
                                        ? Text(
                                            "9",
                                            style: styleNumberCardClasses
                                                .copyWith(color: color999),
                                          )
                                        : index == 5
                                            ? Text(
                                                "10",
                                                style: styleNumberCardClasses
                                                    .copyWith(
                                                        color: pinkColor,
                                                        fontSize: 110,
                                                        shadows: <BoxShadow>[
                                                      boxShadow12b
                                                    ]),
                                              )
                                            : index == 6
                                                ? Text(
                                                    "11",
                                                    style:
                                                        styleNumberCardClasses
                                                            .copyWith(
                                                                color: color888,
                                                                fontSize: 110,
                                                                shadows: <
                                                                    BoxShadow>[
                                                          boxShadow12b
                                                        ]),
                                                  )
                                                : index == 7
                                                    ? Text(
                                                        "12",
                                                        style: styleNumberCardClasses
                                                            .copyWith(
                                                                color: green6,
                                                                fontSize: 115,
                                                                shadows: <
                                                                    BoxShadow>[
                                                              boxShadow12b
                                                            ]),
                                                      )
                                                    : Text(
                                                        "8",
                                                        style:
                                                            styleNumberCardClasses
                                                                .copyWith(
                                                                    color:
                                                                        color888),
                                                      ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
