import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/helper/image_picker.dart';
import 'package:social_media/precentation/main_page/main_page_screen.dart';
import 'package:social_media/service/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController bioControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  // String email = "";
  // String password = "";
  // String userName = "";
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Uint8List? _image;
  // AuthService authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in Page'),
      ),
      body: _isLoading
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
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor: Colors.red,
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://i.stack.imgur.com/l60Hf.png'),
                                backgroundColor: Colors.red,
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
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
                      controller: nameControler,
                      hintText: 'User Name',
                      type: TextInputType.name,
                      icon: Icons.person,
                      formFUnction: (val) {},
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
                      controller: emailControler,
                      hintText: 'Email',
                      type: TextInputType.emailAddress,
                      icon: Icons.email_outlined,
                      formFUnction: (val) {},
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
                      controller: bioControler,
                      hintText: 'Bio',
                      type: TextInputType.text,
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
                      controller: passwordControler,
                      hintText: 'Password',
                      type: TextInputType.name,
                      icon: Icons.album_outlined,
                      suffixIcon: Icons.visibility,
                      formFUnction: (val) {},
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
                        onPressed: signUpUser, child: const Text('Sign Up')),
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

  // registor() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     await authservice
  //         .regsterUserWithEMailAndPassword(userName, email, password)
  //         .then((value) async {
  //       if (value == true) {
  //         // await HelperFunction.saveUserLogedInStus(true);
  //         // await HelperFunction.saveUserNameSf(userName);
  //         // await HelperFunction.saveUserEmailSf(email);
  //         Get.to(MainPage());
  //       } else {
  //         showSnackbar(context, kredcolor, value);
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: emailControler.text,
        password: passwordControler.text,
        username: nameControler.text,
        bio: bioControler.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
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
        controller: controller,
        keyboardType: type,
        onChanged: formFUnction,
        validator: validator,
        obscureText: hide,
      ),
    );
  }
}
