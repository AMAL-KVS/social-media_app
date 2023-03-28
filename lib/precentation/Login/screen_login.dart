import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/helper/helper_function.dart';
import 'package:social_media/precentation/Login/signUp/sighn_up_page.dart';
import 'package:social_media/precentation/main_page/main_page_screen.dart';
import 'package:social_media/precentation/sighnup/screen_sighnup.dart';
import 'package:social_media/service/auth_service.dart';
import 'package:social_media/service/database_service.dart';
import 'package:social_media/widgets/sncack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String email = "";
  String password = "";
  AuthService authservice = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor))
            : Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText:
                                      'Phone number, email address or username'),
                              onChanged: ((value) {
                                setState(() {
                                  email = value;
                                });
                              }),
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Please enter a valid email";
                              })),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Password'),
                              onChanged: ((value) {
                                setState(() {
                                  password = value;
                                });
                              }),
                              validator: (val) {
                                if (val!.length < 6) {
                                  return "Password must be at least 6 characters";
                                } else {
                                  return null;
                                }
                              })),
                      kheight20,
                      ElevatedButton(
                        style: const ButtonStyle(),
                        onPressed: () {
                          logIn();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Forgotten your login details?',
                              style: TextStyle(wordSpacing: -1),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(const SighnUpScreen());
                                },
                                child: const Text(
                                  ' Get help with logging in.',
                                  style: TextStyle(color: kblackcolor),
                                )),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK5q0FP74VV9wbfwP378_7kj7iDomHuKrxkXsxDdUT28V9dlVMNUe-EMzaLwaFhneeuZI&usqp=CAU'),
                                  radius: 20,
                                )),
                            kwidth10,
                            const CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://1000logos.net/wp-content/uploads/2021/04/Facebook-logo.png')),
                            kwidth10,
                          ]),
                      kheight10,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don’t have an account? '),
                            TextButton(
                                onPressed: () {
                                  Get.to(const SignUpScreen());
                                },
                                child: const Text(
                                  'Sign up.',
                                  style: TextStyle(color: kblackcolor),
                                )),
                          ])
                    ])));
  }

//login
  logIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authservice
          .logInWithUserNameAndPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingTheUserData(email);
//saving the  values shared preferencess
          // await HelperFunction.saveUserLogedInStus(true);
          // await HelperFunction.saveUserEmailSf(email);
          // await HelperFunction.saveUserNameSf(snapshot.docs[0]['userName']);

          Get.to(MainPage());
        } else {
          showSnackbar(context, kredcolor, value);
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }
}
