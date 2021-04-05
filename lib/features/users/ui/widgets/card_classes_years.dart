import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/styles.dart';

class CardClassesYears extends StatelessWidget {
  String number;
  String title;
  Color color;
  CardClassesYears({this.number, this.title, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(77),
      width: ScreenUtil().setWidth(328),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius8,
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 6,
                color: blackColor.withOpacity(.16),
                offset: Offset(0, 3))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: styleTitleClassesYears,
          ),
          Row(
            children: [
              VerticalDivider(
                color: whiteColor,
                thickness: 2,
                indent: 12,
                endIndent: 12,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                number,
                style: styleNumClassesYears,
              ),
            ],
          )
        ],
      ),
    );
  }
}
