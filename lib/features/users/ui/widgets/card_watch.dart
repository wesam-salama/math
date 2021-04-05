import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pythagoras/components/models/video.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/icons_name.dart';
import 'package:pythagoras/values/styles.dart';

class CardWatch extends StatelessWidget {
  VideoData videoData;
  int index;

  CardWatch({this.videoData, this.index});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(
          right: 10,
        ),
        width: double.infinity,
        color: whiteColor,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                index < 9 ? "0${index + 1}" : "${index + 1}",
                style: styleNumberWatch,
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(84),
              width: ScreenUtil().setWidth(95),
              decoration: BoxDecoration(
                  borderRadius: borderRadius5,
                  color: hintColor,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(videoData.thumbnail !=
                                  null &&
                              videoData.thumbnail != ''
                          ? videoData.thumbnail
                          : "https://i.guim.co.uk/img/media/1f88ae6599ec098c9c0e4556c68a95f01fd314fc/0_273_4287_2572/master/4287.jpg"),
                      fit: BoxFit.fill)),
            ),
            Container(
              //  padding: EdgeInsets.only(right: 10),
              width: ScreenUtil().setWidth(250),
              //color: pinkColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(170),
                        child: Text(
                          videoData.title != null ? "${videoData.title}" : "",
                          style: styleTitleDetails.copyWith(
                              fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  videoData.statusType == "FREE"
                                      ? iconfire
                                      : videoData.statusType == "PAID"
                                          ? iconscrown
                                          : videoData.statusType == "AVAILABLE"
                                              ? iconfire
                                              : iconfire,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(5),
                              ),
                              Text(
                                videoData.statusType == "FREE"
                                    ? "مجانا"
                                    : videoData.statusType == "PAID"
                                        ? "مدفوع"
                                        : videoData.statusType == "AVAILABLE"
                                            ? "متاح"
                                            : "",
                                style: TextStyle(
                                  color: videoData.statusType == "FREE"
                                      ? pinkColor
                                      : videoData.statusType == "PAID"
                                          ? orangeColor
                                          : videoData.statusType == "AVAILABLE"
                                              ? blueColor
                                              : pinkColor,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: ScreenUtil().setWidth(170),
                    child: Text(
                      videoData.description != null
                          ? videoData.description
                          : "null",
                      style: styleTitleAppBarYears.copyWith(
                          fontSize: 9, color: deepGreenColor),
                    ),
                  ),
                  Text(
                    "",
                    style: styleTimeWatch,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
