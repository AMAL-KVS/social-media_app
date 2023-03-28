import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/controller/theem_controller.dart';
import 'package:social_media/helper/helper_function.dart';
import 'package:social_media/precentation/Login/screen_login.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/precentation/main_page/main_page_screen.dart';
import 'package:social_media/shared/constants.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constands.apiKey,
            appId: Constands.appId,
            messagingSenderId: Constands.messagingSenderId,
            projectId: Constands.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSighnedIn = false;
  @override
  // void initState() {
  //   getLogedInStus();
  //   super.initState();
  // }

  // getLogedInStus() async {
  //   await HelperFunction.getUserLogInStus().then((value) {
  //     if (value != null) {
  //       setState(() {
  //         _isSighnedIn = value;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'social media',
      debugShowCheckedModeBanner: false,
      darkTheme: MyTheme.darkTheme,
      theme: MyTheme.lightTheme,
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    );
  }
}
