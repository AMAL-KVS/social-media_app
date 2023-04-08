import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/precentation/Login/screen_login.dart';
import 'package:social_media/service/auth_service.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  String userName = "";
  SettingsScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AuthService authService = AuthService();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settigs'),
        ),
        body: Column(children: [
          ListTile(
              title: const Text('privacy'),
              onLongPress: () {},
              leading: const Icon(Icons.lock_outline)),
          ListTile(
              title: const Text('Account'),
              onLongPress: () {},
              leading: const Icon(Icons.account_box)),
          ListTile(
              title: const Text('Theme'),
              onLongPress: () {},
              leading: const Icon(Icons.colorize)),
          ListTile(
              title: const Text('About'),
              onLongPress: () {},
              leading: const Icon(Icons.info)),
          ListTile(
              title: const Text('Security'),
              onLongPress: () {},
              leading: const Icon(Icons.security)),
          ListTile(
              title: Text('Log Out _$userName'),
              leading: const Icon(Icons.lock_outline),
              onLongPress: () async {
                //  await authService.sighnOut();
                // Get.offAll(const LoginScreen());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: ((context) => LoginScreen())),
                    (route) => false);
                log('log out');
              })
        ]));
  }
}
