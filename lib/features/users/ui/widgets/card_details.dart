import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/shadows.dart';
import 'package:pythagoras/values/styles.dart';

class CardDetails extends StatelessWidget {
  final unitdata;
  Color color;
  int index;
  CardDetails({this.unitdata, this.color, this.index});

  @override
  Widget build(BuildContext context) {
    print("1111111111111111111111111111111111111111111111111111");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      //height: ScreenUtil().setHeight(105),
      width: ScreenUtil().setWidth(350),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: borderRadius8,
          boxShadow: <BoxShadow>[boxShadow6]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: ScreenUtil().setHeight(90),
            width: ScreenUtil().setWidth(85),
            decoration:
                BoxDecoration(borderRadius: borderRadius8, color: color),
            child: Center(
              child: Text(
                "${index + 1}",
                style: styleNumberDetails,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unitdata.title,
                  style: styleTitleDetails,
                ),
                Text(
                  unitdata.description == null
                      ? "لا يوجد وصف"
                      : unitdata.description,
                  style: styleSubTitleDetails,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
