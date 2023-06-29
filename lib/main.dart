import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/controller/theem_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/precentation/splash/screen_splash.dart';
import 'package:social_media/shared/constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

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
  final navigatorKey = GlobalKey<NavigatorState>();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  runApp(MyApp(
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: GetMaterialApp(
            navigatorKey: navigatorKey,
            title: 'social media',
            debugShowCheckedModeBanner: false,
            darkTheme: MyTheme.darkTheme,
            theme: MyTheme.lightTheme,
            themeMode: ThemeMode.system,
            home: const SplashScreen()));
  }
}
