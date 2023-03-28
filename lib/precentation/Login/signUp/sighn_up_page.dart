import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/helper/helper_function.dart';
import 'package:social_media/precentation/main_page/main_page_screen.dart';
import 'package:social_media/service/auth_service.dart';
import 'package:social_media/widgets/sncack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TextEditingController nameControler = TextEditingController();
  // TextEditingController emailControler = TextEditingController();
  // TextEditingController phoneNumberControler = TextEditingController();
  // TextEditingController passwordControler = TextEditingController();
  String email = "";
  String password = "";
  String userName = "";
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthService authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in Page'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const BoxDecoration(
                          color: kwhitecolor,
                          image: DecorationImage(
                              image: AssetImage(
                                  'lib/precentation/assets/107385-login.gif'))),
                    ),
                    kheight10,
                    FromFeildWidgets(
                      hintText: 'User Name',
                      type: TextInputType.name,
                      icon: Icons.person,
                      formFUnction: (val) {
                        setState(() {
                          userName = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          return null;
                        } else {
                          return "Name cannot be empty";
                        }
                      },
                    ),
                    kheight10,
                    FromFeildWidgets(
                      hintText: 'Email',
                      type: TextInputType.emailAddress,
                      icon: Icons.email_outlined,
                      formFUnction: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                    ),
                    kheight10,
                    FromFeildWidgets(
                      hintText: 'Phone Number',
                      type: TextInputType.number,
                      icon: Icons.phone,
                      formFUnction: (val) {},
                      validator: (val) {
                        if (val!.length < 9) {
                          return "Phone Numer must be at least 10 digits";
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight10,
                    FromFeildWidgets(
                      hintText: 'Password',
                      type: TextInputType.name,
                      icon: Icons.album_outlined,
                      suffixIcon: Icons.visibility,
                      formFUnction: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) {
                        if (val!.length < 6) {
                          return "password to short";
                        } else {
                          return null;
                        }
                      },
                      hide: true,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          registor();
                        },
                        child: const Text('Sign Up')),
                    kheight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK5q0FP74VV9wbfwP378_7kj7iDomHuKrxkXsxDdUT28V9dlVMNUe-EMzaLwaFhneeuZI&usqp=CAU'),
                            radius: 20,
                          ),
                        ),
                        kwidth10,
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://1000logos.net/wp-content/uploads/2021/04/Facebook-logo.png'),
                        ),
                        kwidth10,
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  registor() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authservice
          .regsterUserWithEMailAndPassword(userName, email, password)
          .then((value) async {
        if (value == true) {
          // await HelperFunction.saveUserLogedInStus(true);
          // await HelperFunction.saveUserNameSf(userName);
          // await HelperFunction.saveUserEmailSf(email);
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

// ignore: must_be_immutable
class FromFeildWidgets extends StatelessWidget {
  TextInputType type;
  IconData? suffixIcon;
  IconData icon;
  TextEditingController? controller;
  String hintText;
  bool hide;
  Function(String) formFUnction;
  String? Function(String?)? validator;
  FromFeildWidgets(
      {Key? key,
      required this.hintText,
      this.controller,
      required this.type,
      required this.icon,
      required this.formFUnction,
      this.validator,
      this.suffixIcon,
      this.hide = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixIcon: Icon(icon),
            suffixIcon: Icon(suffixIcon)),
        //controller: controller,
        keyboardType: type,
        onChanged: formFUnction,
        validator: validator,
        obscureText: hide,
      ),
    );
  }
}
