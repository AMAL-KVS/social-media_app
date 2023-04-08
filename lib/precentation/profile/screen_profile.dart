import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/precentation/profile/widgets/show_diloge_posts.dart';

class ProfileBaseScreen extends StatefulWidget {
  const ProfileBaseScreen({Key? key}) : super(key: key);

  @override
  State<ProfileBaseScreen> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ProfileBaseScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    //TabController tabController = TabController(length: 3, vsync: this);

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
      ProfileStackWIdgets(
        uid: uid,
      )
    ]))));
  }
}
