import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/widgets/session_one.dart';
import 'package:social_media/precentation/widgets/session_three.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class HomeScreen extends StatefulWidget {
  final String uid = '';
  bool isLoading = true;
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    setState(() {
      widget.isLoading = true;
    });
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    log(FirebaseAuth.instance.currentUser!.displayName.toString());
    setState(() {
      widget.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading == true
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: kwhitecolor,
            body: ValueListenableBuilder(
                valueListenable: scrollNotifier,
                builder: (BuildContext context, index, _) {
                  final UserProvider userProvider =
                      Provider.of<UserProvider>(context);
                  return NotificationListener<UserScrollNotification>(
                      onNotification: ((notification) {
                        final ScrollDirection direction =
                            notification.direction;
                        if (direction == ScrollDirection.reverse) {
                          scrollNotifier.value = false;
                        } else if (direction == ScrollDirection.forward) {
                          scrollNotifier.value = true;
                        }
                        return true;
                      }),
                      child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(children: [
                            ListView(
                                padding: const EdgeInsets.only(top: 90),
                                physics: const BouncingScrollPhysics(),
                                children: const [
                                  //    StoryContainer(),
                                  SessionThree()
                                ]),
                            scrollNotifier.value == true
                                ? SessionOne(
                                    userName: userProvider.getUser.username)
                                : kheight10
                          ])));
                }));
  }
}
