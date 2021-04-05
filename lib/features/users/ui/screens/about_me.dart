import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/styles.dart';

import '../../../../animate_do.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pinkColor,
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: pinkColor,
        child: Column(
          children: [
            FadeIn(
              animate: true,
              duration: Duration(milliseconds: 1000),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: ScreenUtil().setHeight(200),
                    width: double.infinity,
                    child: SvgPicture.asset(
                      backgroundlogin,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
        
            Text(
              "فيثاغورث ",
              style: styleForgetPassLogIn.copyWith(fontSize: 22),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "منصة تعليمية عمانية رائدة  في مادة الرياضيات ..",
                    style: styleAboutMe,
                  ),
                  Text(
                    "رؤيتنا :",
                    style: styleForgetPassLogIn.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "إنطلاقا من مبدأ (الرياضيات للجميع)  التي تقوم عليها كل العلوم في الحياة ، نسعى إلى تغيير الطريقة التقليدية لتعلم الرياضيات ، وتغيير نظرة التشائم لدى غالبية المجتمعات إتجاه هذا العِلم الجميل على إنها علم مجرد لا يحمل في طياته أي أحاسيس لدى المُتلقي . بإذن الله سنغير نظرتك إتجاه الرياضيات التي لطالما أنهكت ذهنك وجعلتك موقناً أنك غير قادر على فهمها و استيعابها .. سنسعى جاهدين من خلال هذا التطبيق لجعل الرياضيات ممتعة تلامس عقلك و وجدانك .. لأنها بإختصار",
                    style: styleAboutMe2,
                  ),
                  Text(
                    "(أسلوب حياة)",
                    style: styleAboutMe2.copyWith(color: pinkColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
