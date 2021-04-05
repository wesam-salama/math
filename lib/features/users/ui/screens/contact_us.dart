import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/icons_name.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:pythagoras/values/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../animate_do.dart';

class ContactUs extends StatelessWidget {
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
                    height: ScreenUtil().setHeight(250),
                    width: double.infinity,
                    child: SvgPicture.asset(
                      backgroundlogin,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
        
           Text("تابعنا :",style: styleForgetPassLogIn.copyWith(
             fontSize: 22
           ),),

           SizedBox(
             height: ScreenUtil().setHeight(20),

           ),

           Container(
             width: ScreenUtil().setWidth(170),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                  
                   InkWell(
                       onTap: ()async{
                        var url ="https://www.instagram.com/pythagorath_center/";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                     },
                                        child: Container(
                       height: ScreenUtil().setHeight(45),
                       width: ScreenUtil().setWidth(45),
                       child: Image.asset(instagram,fit: BoxFit.fill,),
                     ),
                   ),
                   InkWell(
                       onTap: ()async{
                        var url ="https://www.youtube.com/watch?v=ajHQJwuPcTc&feature=youtu.be";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                     },
                                        child: Container(
                       height: ScreenUtil().setHeight(50),
                       width: ScreenUtil().setWidth(50),
                       child: Image.asset(youtube,fit: BoxFit.fill,),
                     ),
                   ),
                 ],
               ),
           ),
            SizedBox(
             height: ScreenUtil().setHeight(20),

           ),
           Text("تواصل معنا :",style: styleForgetPassLogIn.copyWith(
             fontSize: 22
           ),),

           SizedBox(
             height: ScreenUtil().setHeight(10),

           ),

           Container(
             width: ScreenUtil().setWidth(200),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   InkWell(
                     onTap: ()async{
                        var url ="https://wa.me/96879192497";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                     },
                                        child: Container(
                       height: ScreenUtil().setHeight(50),
                       width: ScreenUtil().setWidth(50),
                       child: Image.asset(whatsapp,fit: BoxFit.fill,),
                     ),
                   ),
                 ],
               ),
           ),
           SizedBox(
             height: ScreenUtil().setHeight(65),

           ),


           Container(
             //color: Colors.amber,
               height: ScreenUtil().setHeight(170),
               width: double.infinity,
               child: Image.asset(
                 imagebottom,
                 fit: BoxFit.fill,
               )),


          
        ],
      ),
      
    ),
    );
  }
}
