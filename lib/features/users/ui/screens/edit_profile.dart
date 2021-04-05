import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_Text_Field_controller.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_bottom.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_dropdown.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/styles.dart';

class EditProfile extends StatefulWidget {
  String name;
  String mobile;
  String location;
  String supervisor;
  String supervisorType;
  String gender;
  int levelId;
  EditProfile(
      {this.name,
      this.mobile,
      this.location,
      this.supervisor,
      this.supervisorType,
      this.gender,
      this.levelId});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime selectedDate = DateTime.now();

  final GlobalKey<FormState> editProfileFormkey =
      GlobalKey<FormState>(debugLabel: '_editProfileFormkey');

  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerMobile;
  TextEditingController textEditingControllerLocation;
  TextEditingController textEditingControllerSupervisor;
  TextEditingController textEditingControlleSupervisorType;

  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(MeUserEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authProviderUserWithListen = Provider.of<AuthProviderUser>(context);
    final authProviderUserNoListen =
        Provider.of<AuthProviderUser>(context, listen: false);

    authProviderUserWithListen.setName(widget.name);
    authProviderUserWithListen.setMobile(widget.mobile);
    authProviderUserWithListen.setLocation(widget.location);
    authProviderUserWithListen.setFatherName(widget.supervisor);
    authProviderUserWithListen.setLink(widget.supervisorType);
    authProviderUserWithListen
        .setValueGender(widget.gender == "MALE" ? "ذكر" : "انثى");
    textEditingControllerMobile = TextEditingController(text: widget.mobile);

    authProviderUserWithListen.setValueClass(widget.levelId == 1
        ? "الصف الخامس"
        : widget.levelId == 2
            ? "الصف السادس"
            : widget.levelId == 3
                ? "الصف السابع"
                : widget.levelId == 4
                    ? "الصف الثامن"
                    : widget.levelId == 5
                        ? "الصف التاسع"
                        : widget.levelId == 6
                            ? "الصف العاشر"
                            : widget.levelId == 7
                                ? "الصف الحادي عشر"
                                : widget.levelId == 8
                                    ? "الصف الثاني عشر"
                                    : "");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          "بياناتك",
          style: styleEditeAppBar,
        ),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return isBob(context);
        },
        child: Form(
          key: editProfileFormkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              CustomTextFieldControler(
                initialValue: widget.name,
                hintTitle: widget.name,
                icon: Icon(
                  Icons.person,
                  size: 20,
                ),
                onSaved: authProviderUserWithListen.setName,
                onValidate: authProviderUserWithListen.validateName,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomDropDown(
                type: "gender",
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: InkWell(
                  onTap: () {
                    return showRoundedDatePicker(
                      context: context,
                      height: 320,
                      theme: ThemeData(primarySwatch: Colors.pink),
                      initialDate: selectedDate,
                      firstDate: DateTime(selectedDate.year - 100),
                      lastDate: DateTime(selectedDate.year + 10),
                      borderRadius: 16,
                    ).then((value) {
                      selectedDate = value;
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: ScreenUtil().setHeight(45),
                    width: double.infinity,
                    padding: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        color: backgroundTextFieldColor.withOpacity(.12),
                        borderRadius: borderRadius22),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.date_range,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                            flex: 12,
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                "${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: "Ithrabold",
                                    fontSize: 14),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomDropDown(
                type: "class",
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFieldControler(
                initialValue: widget.location,
                hintTitle: widget.location,
                icon: Icon(
                  Icons.location_on,
                  size: 20,
                ),
                onSaved: authProviderUserWithListen.setLocation,
                onValidate: authProviderUserWithListen.validateLocation,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFieldControler(
                cont: textEditingControllerMobile,
                //  initialValue: widget.mobile,
                keyboardType: TextInputType.number,
                hintTitle: widget.mobile,
                icon: Icon(
                  Icons.phone,
                  size: 20,
                ),
                onSaved: authProviderUserWithListen.setMobile,
                onValidate: authProviderUserWithListen.validateMobile,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFieldControler(
                hintTitle: "كلمة السر",
                icon: Icon(
                  Icons.lock,
                  size: 20,
                ),
                onSaved: authProviderUserWithListen.setPassword,
                onValidate: authProviderUserWithListen.validatePassword,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "(اتركها فارغة لعدم التعديل)",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: orangeColor),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: ScreenUtil().setWidth(75),
                      child: Divider(
                        thickness: 2,
                        endIndent: 20,
                      )),
                  Text(
                    "معلومات ولي الامر",
                    style: styleTitleSignUpLight,
                  ),
                  Container(
                      width: ScreenUtil().setWidth(75),
                      child: Divider(
                        thickness: 2,
                        endIndent: 20,
                      ))
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFieldControler(
                initialValue: widget.supervisor,
                hintTitle: widget.supervisor,
                icon: Icon(
                  Icons.person,
                  size: 20,
                ),
                onSaved: authProviderUserWithListen.setFatherName,
                onValidate: authProviderUserWithListen.validateFatherName,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              CustomTextFieldControler(
                initialValue: widget.supervisorType,
                hintTitle: widget.supervisorType,
                icon: Icon(
                  Icons.group,
                  size: 20,
                ),
                onSaved: authProviderUserWithListen.setLink,
                onValidate: authProviderUserWithListen.validateLink,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(50),
                ),
                width: ScreenUtil().setWidth(202),
                child: CustomBottom(
                  title: "تعديل",
                  color: orangeColor,
                  route: () {
                    authProviderUserNoListen.onSavedEditProfileForm(
                        context, editProfileFormkey);

                    // push(context, LogInScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
