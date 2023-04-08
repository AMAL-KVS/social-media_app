import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/precentation/login/screen_login.dart';
import 'package:social_media/service/auth_service.dart';
import 'package:social_media/widgets/icon_button_widgets.dart';

// ignore: must_be_immutable
class SessionOne extends StatelessWidget {
  String userName = '';
  SessionOne({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthMethods authService = AuthMethods();
    return AnimatedContainer(
      duration: const Duration(microseconds: 2000),
      width: double.infinity,
      height: 100,
      // color: kblackcolor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButtonWidgets(
                icon: const Icon(Icons.camera_alt), ontap1: () {}),
          ),
          const Spacer(),
          Text("@_$userName",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButtonWidgets(
                icon: const Icon(Icons.logout),
                ontap1: () async {
                  await authService.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                      (route) => false);
                }),
          )
        ],
      ),
    );
  }
}
