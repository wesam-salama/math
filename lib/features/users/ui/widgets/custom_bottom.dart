import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/styles.dart';

class CustomBottom extends StatelessWidget {
 final String title;
 final Color color;
 final Function route;
  CustomBottom({this.title, this.color, this.route});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: route,
      child: Container(
        height: ScreenUtil().setHeight(40),
        width: ScreenUtil().setWidth(205),
        decoration: BoxDecoration(borderRadius: borderRadius22, color: color),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                title,
                style: styleTitleBottom,
              ),
            )),
      ),
    );
  }
}
