import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/precentation/home/home.dart';
import 'package:social_media/precentation/main_page/bottom_nav.dart';
import 'package:social_media/precentation/messege/screen_messege.dart';
import 'package:social_media/precentation/newposts/screen_new_posts.dart';
import 'package:social_media/precentation/notifications/screen_notification.dart';
import 'package:social_media/precentation/profile/screen_profile.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final _pages = [
    HomeScreen(),
    MessagesScreen(),
    const NewPostsScreen(),
    ProfileBaseScreen(uid: FirebaseAuth.instance.currentUser!.uid),
    const NotificationsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: indexChangeNotifier,
              builder: (context, int index, _) {
                return _pages[index];
              })),
      bottomNavigationBar: const BottomNavigationBarWidgets(),
    );
  }
}
