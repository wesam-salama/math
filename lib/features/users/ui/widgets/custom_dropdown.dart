import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';

class CustomDropDown extends StatelessWidget {
  String type;
  CustomDropDown({this.type});
  @override
  Widget build(BuildContext context) {
    final authProviderUserWithListen = Provider.of<AuthProviderUser>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(right: 15),
        height: ScreenUtil().setHeight(45),
        width: double.infinity,
        decoration: BoxDecoration(
            color: backgroundTextFieldColor.withOpacity(.12),
            borderRadius: borderRadius22),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                type == "gender"
                    ? Icons.group
                    : type == "class"
                        ? Icons.book
                        : type == "state" ? Icons.location_on : Icons.group,
                color: Colors.grey[600],
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                    
                      hint: Text(
                        type == "gender"
                            ? "الجنس"
                            : type == "class"
                                ? "الصف"
                                : type == "state" ? "المنطقة" : "",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: "Ithrabold",
                          fontSize: 14
                          ),
                      ),
                      isExpanded: true,
                      value: type == "gender"
                          ? authProviderUserWithListen.valueGender
                          : type == "class"
                              ? authProviderUserWithListen.valueClass
                              : type == "state"
                                  ? authProviderUserWithListen.valueState
                                  : authProviderUserWithListen.valueGender,
                      items: type == "gender"
                          ? authProviderUserWithListen.gender
                              .map(
                                (e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.start,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    onTap: () {
                                    },
                                    value: e),
                              )
                              .toList()
                          : type == "class"
                              ? authProviderUserWithListen.className
                                  .map(
                                    (e) => DropdownMenuItem(
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.start,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        onTap: () {
                                        },
                                        value: e),
                                  )
                                  .toList()
                              : type == "state"
                                  ? authProviderUserWithListen.state
                                      .map(
                                        (e) => DropdownMenuItem(
                                            child: Text(
                                              e,
                                              textAlign: TextAlign.start,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            onTap: () {
                                            },
                                            value: e),
                                      )
                                      .toList()
                                  : null,
                      onChanged: (value) {
                        type == "gender"
                            ? authProviderUserWithListen.setValueGender(value)
                            : type == "class"
                                ? authProviderUserWithListen.setValueClass(value)
                                : type == "state"
                                    ? authProviderUserWithListen
                                        .setValueState(value)
                                    : authProviderUserWithListen
                                        .setValueGender(value);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
