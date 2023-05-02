import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/precentation/profile/widgets/show_diloge_posts.dart';

class ProfileBaseScreen extends StatefulWidget {
  final uid;
  const ProfileBaseScreen({Key? key, required this.uid}) : super(key: key);

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
                child: Column(children: [
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            return ProfileStackWIdgets(uid: widget.uid, snap: snapshot);
          })
    ]))));
  }
}
