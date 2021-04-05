import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/features/users/GetApp/app_get.dart';
import 'package:pythagoras/features/users/providers/auth_providers_user.dart';
import 'package:pythagoras/features/users/providers/user_provider.dart';
  import 'package:pythagoras/services/notification_handler.dart';
import 'package:pythagoras/services/socket_class.dart';
import 'package:pythagoras/services/sp_helper.dart';
import 'package:pythagoras/splash_screen.dart';
import 'package:pythagoras/values/images_name.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bloc/bloc_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  int co = await SPHelper.spHelper.getCountNotification();

  // initSvg();
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, backgroundlogin), null);
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, homeimage), null);
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, classes), null);
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, logospalsh), null);
  runApp(co == null ? MyApp(0) : MyApp(co));
}

class MyApp extends StatefulWidget {
  int cou;
  MyApp(this.cou);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ConnectivityService connectivityService;
  @override
  void initState() {
    super.initState();
    // connectivityService = ConnectivityService();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AppGet());
    return OverlaySupport(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserBloc(EmptyTasksState())),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProviderUser>(
                create: (context) => AuthProviderUser()),
            ChangeNotifierProvider<UserProvider>(
                create: (context) => UserProvider()),
          ],
          child: MaterialApp(
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('ar', ''), // Hebrew, no country code
            ],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyApp2(widget.cou),
          ),
        ),
      ),
    );
  }
}

class MyApp2 extends StatefulWidget {
  int cou;
  MyApp2(this.cou);
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  AppGet authGet = Get.find();
  @override
  void initState() {
    NotificationHandler().initialization();
    // CheckInternet().checkConnection(context);
    //NotificationHandel().initi();
    SocketHandel().ini(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authGet.setCountNotifiSp(widget.cou);
    Provider.of<AuthProviderUser>(context).setCountNotificationSp(widget.cou);

    return SplashScreen();
  }
}
