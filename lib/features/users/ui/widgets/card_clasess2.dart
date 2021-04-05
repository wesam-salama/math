import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pythagoras/components/models/levels.dart';

class YearListAddress extends StatelessWidget {
  int index;
  List<LevelsData> dataLevel;
  YearListAddress({this.dataLevel, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13),
      child: Stack(alignment: Alignment.centerRight, children: [
        Container(
          width: double.infinity,
          height: ScreenUtil().setHeight(100),
          child: Image.asset(
            'assets/images/${index + 5}.png',
            fit: BoxFit.fill,
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.only(
                right: 10, top: 4, left: index + 5 <= 9 ? 83 : 131, bottom: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dataLevel[index].name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${dataLevel[index].usersCount} طالب مسجل",
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Divider(
                  height: ScreenUtil().setHeight(3),
                  color: Colors.white,
                  thickness: 1,
                  indent: ScreenUtil().setWidth(50),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  dataLevel[index].description,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
