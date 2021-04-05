import 'package:flutter/material.dart';
import 'package:pythagoras/values/styles.dart';

class CustomTextFiledPayment extends StatefulWidget {
  final String title;
  final Function onSaved;
  final Function onValidate;
  int maxLength;
  TextInputType keyboardType;
  String initialValue;
  FocusNode focaseNode;
  Icon icon;

  CustomTextFiledPayment({
    this.title,
    this.onSaved,
    this.onValidate,
    this.maxLength,
    this.keyboardType,
    this.initialValue,
    this.focaseNode,
    this.icon
  });

  @override
  _CustomTextFiledPaymentState createState() => _CustomTextFiledPaymentState();
}

class _CustomTextFiledPaymentState extends State<CustomTextFiledPayment> {
  bool isSecret = false;

  @override
  Widget build(BuildContext context) {
    var title = widget.title;
    return Container(
      // color: Colors.red,
      //alignment: Alignment.bottomRight,
      child: TextFormField(
        focusNode: widget.focaseNode,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLength == 100 ? 4 : 1,
        maxLength: widget.maxLength,
        onChanged: (value) {
          widget.onSaved(value);
        },
        obscureText: isSecret,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 10.0,bottom: 5),
          labelText: title,
          labelStyle: styleCustomFieldLable,
          suffixIcon: widget.icon
          
        ),
        onSaved: (value) {
          widget.onSaved(value);
        },
        validator: (value) {
          return widget.onValidate(value);
        },
      ),
    );
  }
}
