import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/helper/helper_function.dart';
import 'package:social_media/precentation/widgets/session_one.dart';
import 'package:social_media/precentation/widgets/session_three.dart';
import 'package:social_media/precentation/widgets/story_container.dart';
import 'package:social_media/service/auth_service.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();

  @override
  // void initState() {
  //   gettingUserData();
  //   super.initState();
  // }

  // gettingUserData() async {
  //   await HelperFunction.getUserEmailFromSf().then((value) {
  //     setState(() {
  //       email = value!;
  //     });
  //   });
  //   await HelperFunction.getUserNameFromSf().then((value) {
  //     setState(() {
  //       userName = value!;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SessionOne(userName: userName),
      ),
      backgroundColor: kwhitecolor,
      body: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
                onNotification: ((notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  return true;
                }),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: const [
                    // SessionOne(),
                    StoryContainer(),
                    SessionThree(),
                  ],
                ));
          }),
    );
  }
}
