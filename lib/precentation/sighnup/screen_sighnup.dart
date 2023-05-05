import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/login/screen_login.dart';

class SighnUpScreen extends StatelessWidget {
  const SighnUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController forgotpassworcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhitecolor,
        title: const Text('Forgot your password'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(mainLogo),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: forgotpassworcontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your email '),
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Please enter a valid email";
                    })),
            ElevatedButton(
                onPressed: () async {
                  var foegotemail = forgotpassworcontroller.text.trim();
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: foegotemail)
                        .then((value) {
                      Get.off(() => const LoginScreen());
                    });
                  } catch (e) {
                    //var err = e.toString();
                    return;
                  }
                },
                child: const Text('Forgot your Password'))
          ],
        ),
      ),
    );
  }
}
