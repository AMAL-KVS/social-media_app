import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/Login/screen_login.dart';
import 'package:social_media/precentation/settings/other/account_screeen.dart';
import 'package:social_media/service/auth_service.dart';
import 'other/privacy_policy_screen.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  String userName = "";
  SettingsScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthMethods authService = AuthMethods();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kwhitecolor,
          title: const Text('Settigs'),
        ),
        body: Column(children: [
          ListTile(
              title: const Text('privacy'),
              onTap: () {
                Get.to(const WebViewApp());
              },
              leading: const Icon(Icons.lock_outline)),
          ListTile(
              title: const Text('Account'),
              onTap: () {
                Get.to(const AccountScreen());
              },
              leading: const Icon(Icons.account_box)),
          ListTile(
              title: const Text('About'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                          title: Column(
                            children: const [Text("AmJoZ"), Text('1.0.0')],
                          ),
                          content: const Text(
                              'AmJoZ is designed and developed by\n AMAL KV'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK',
                                    style: TextStyle(color: kblackcolor)))
                          ]);
                    });
              },
              leading: const Icon(Icons.info)),
          ListTile(
              title: const Text('Terms And Contions'),
              onLongPress: () {},
              leading: const Icon(Icons.security)),
          ListTile(
              title: Text('Log Out _$userName'),
              leading: const Icon(Icons.lock_outline),
              onLongPress: () async {
                await authService.signOut();
                Get.offAll(const LoginScreen());

                log('log out');
              }),
          const Spacer(),
          const Text(
            'A m J o Z  \n   1.0.0',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          kheight20
        ]));
  }
}
