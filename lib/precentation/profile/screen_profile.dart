import 'package:flutter/material.dart';
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
    //TabController tabController = TabController(length: 3, vsync: this);

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: const [ProfileStackWIdgets()]))));
  }
}
