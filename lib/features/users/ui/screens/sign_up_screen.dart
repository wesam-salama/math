import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/ui/screens/condition.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_Text_Field.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_bottom.dart';
import 'package:pythagoras/features/users/ui/widgets/custom_dropdown.dart';
import 'package:pythagoras/values/borders.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/styles.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime selectedDate = DateTime.now();

  final GlobalKey<FormState> registerFormkey =
      GlobalKey<FormState>(debugLabel: '_registerFormKey');

  @override
  Widget build(BuildContext context) {
    final authProviderUserWithListen = Provider.of<AuthProviderUser>(context);
    final authProviderUserNoListen =
        Provider.of<AuthProviderUser>(context, listen: false);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: orangeColor,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: whiteColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
      body: Form(
        key: registerFormkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            InkWell(
              onTap: () async {
                PickedFile pickedFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  maxWidth: 1800,
                  maxHeight: 1800,
                );
                if (pickedFile != null) {
                  File croppedFile = await ImageCropper.cropImage(
                      sourcePath: pickedFile.path,
                      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                      aspectRatioPresets: Platform.isAndroid
                          ? [
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.ratio3x2,
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.ratio4x3,
                              CropAspectRatioPreset.ratio16x9
                            ]
                          : [
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.ratio3x2,
                              CropAspectRatioPreset.ratio4x3,
                              CropAspectRatioPreset.ratio5x3,
                              CropAspectRatioPreset.ratio5x4,
                              CropAspectRatioPreset.ratio7x5,
                              CropAspectRatioPreset.ratio16x9
                            ],
                      androidUiSettings: AndroidUiSettings(
                          toolbarTitle: 'Cropper',
                          toolbarColor: Colors.deepOrange,
                          toolbarWidgetColor: Colors.white,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      iosUiSettings: IOSUiSettings(
                        title: 'Cropper',
                      ));
                  authProviderUserWithListen.setImageProfile(croppedFile);
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    authProviderUserWithListen.imageProfile == null
                        ? CircleAvatar(
                            backgroundColor: orangeColor,
                            radius: 54,
                            child: Icon(
                              Icons.person,
                              color: whiteColor,
                              size: 80,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                                authProviderUserWithListen.imageProfile),
                            radius: 54,
                          ),
                    CircleAvatar(
                        backgroundColor: whiteColor,
                        radius: 15,
                        child: CircleAvatar(
                            backgroundColor: orangeColor,
                            radius: 13,
                            child: Icon(
                              Icons.camera_enhance,
                              size: 18,
                              color: whiteColor,
                            )))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "إختر الصورة الخاصة بك",
                style: styleTitleSignUp,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  child: Column(
                    children: [
                      CustomTextField(
                        hintTitle: "الإسم",
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
                              if (value != null) {
                                selectedDate = value;
                              } else {
                                selectedDate = DateTime.now();
                              }

                              setState(() {});
                            });
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(45),
                            width: double.infinity,
                            padding: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                                color:
                                    backgroundTextFieldColor.withOpacity(.12),
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
                      CustomTextField(
                        hintTitle: "المنطقة",
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
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        hintTitle: "رقم الهاتف",
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
                      CustomTextField(
                        hintTitle: "كلمة السر",
                        icon: Icon(
                          Icons.lock,
                          size: 20,
                        ),
                        onSaved: authProviderUserWithListen.setPassword,
                        onValidate: authProviderUserWithListen.validatePassword,
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
                            "معلومات ولي الأمر",
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
                      CustomTextField(
                        hintTitle: "إسم ولي الأمر",
                        icon: Icon(
                          Icons.person,
                          size: 20,
                        ),
                        onSaved: authProviderUserWithListen.setFatherName,
                        onValidate:
                            authProviderUserWithListen.validateFatherName,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      CustomTextField(
                        hintTitle: "صلة القرابة بولي الأمر",
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
                          title: "إنشاء حساب",
                          color: orangeColor,
                          route: () {
                            authProviderUserNoListen.onSavedRegisterForm(
                                context, registerFormkey);

                            // push(context, LogInScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "من خلال النقر على إنشاء حساب  فإنك توافق على ",
                style: styleSubTitleSignUpLight,
              ),
            ),
            InkWell(
              onTap: () {
                push(context, Conditions());
              },
              child: Align(
                alignment: Alignment.center,
                child: Text("الشروط والأحكام",
                    style:
                        styleSubTitleSignUpLight.copyWith(color: orangeColor)),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
              child: BlocBuilder<UserBloc, BlocStates>(
                builder: (context, state) {
                  if (state is TasksLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is EmptyTasksState) {
                    return Center(
                        //  child: Text('Empty Tasks'),
                        );
                  } else if (state is TasksErrorState) {
                    Center(
                      child: Text(state.error),
                    );

                    return Center(
                      child: Container(),
                    );
                  } else if (state is SuccessState) {
                    //dpush(context, LogInScreen());
                    return Container();
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
