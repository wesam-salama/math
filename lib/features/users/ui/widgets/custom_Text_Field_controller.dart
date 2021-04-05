import 'package:flutter/material.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/styles.dart';

class CustomTextFieldControler extends StatefulWidget {
  String hintTitle;
  Icon icon;
  final Function onSaved;
  final Function onValidate;
  TextInputType keyboardType;
  String initialValue;
  FocusNode focaseNode;
  TextEditingController cont;
  CustomTextFieldControler(
      {this.hintTitle,
      this.icon,
      this.onSaved,
      this.onValidate,
      this.keyboardType,
      this.focaseNode,
      this.initialValue,
      this.cont
      });

  @override
  _CustomTextFieldControlerState createState() =>
      _CustomTextFieldControlerState();
}

class _CustomTextFieldControlerState extends State<CustomTextFieldControler> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    int nu = 8;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        initialValue: widget.initialValue,
         controller: widget.cont,
        maxLength: widget.hintTitle == "رقم الهاتف" ? nu : null,
        keyboardType: widget.keyboardType,
        obscureText: widget.hintTitle == "كلمة السر" && isShow == false
            ? true
            : widget.hintTitle == "كلمة السر" && isShow == true
                ? false
                : false,
        onChanged: (value) {
          widget.onSaved(value);
        },
        onSaved: (value) {
          widget.onSaved(value);
        },
        validator: (value) {
          return widget.onValidate(value);
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: backgroundTextFieldColor.withOpacity(.12),
            contentPadding: EdgeInsets.only(top: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: borderRadius22),
            hintText: widget.hintTitle,
            hintStyle: styleTextFieldLogIn,
            prefixIcon: widget.icon,
            suffixIcon: widget.hintTitle == "كلمة السر" && isShow == false
                ? IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      isShow = !isShow;
                      setState(() {});
                    })
                : widget.hintTitle == "كلمة السر" && isShow == true
                    ? IconButton(
                        icon: Icon(Icons.visibility_off),
                        onPressed: () {
                          isShow = !isShow;
                          setState(() {});
                        })
                    : null),
      ),
    );
  }
}
