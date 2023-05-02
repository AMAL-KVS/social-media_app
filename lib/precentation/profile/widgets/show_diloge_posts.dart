import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/login/screen_login.dart';
import 'package:social_media/precentation/messege/chat_screen.dart';
import 'package:social_media/precentation/profile/widgets/builder_widgggets.dart';
import 'package:social_media/precentation/profile/widgets/follow_button.dart';
import 'package:social_media/precentation/profile/widgets/text_button_widgets.dart';
import 'package:social_media/precentation/settings/screen_settings.dart';
import 'package:social_media/service/auth_service.dart';
import 'package:social_media/service/firestore_methods.dart';
import 'package:social_media/widgets/icon_button_widgets.dart';
import 'package:social_media/widgets/sncack_bar.dart';
import 'package:social_media/Application/user_model.dart' as model;
import '../followers/screen_followers.dart';

Future<void> showAlertDialog(
    BuildContext context, String imageUrl, String caption) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            // <-- SEE HERE

            content: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                    child: Image(
                        fit: BoxFit.cover, image: NetworkImage(imageUrl)))));
      });
}

class ProfileStackWIdgets extends StatefulWidget {
  final uid;
  final snap;
  const ProfileStackWIdgets({Key? key, required this.uid, required this.snap})
      : super(key: key);

  @override
  State<ProfileStackWIdgets> createState() => _ProfileStackWIdgetsState();
}

class _ProfileStackWIdgetsState extends State<ProfileStackWIdgets> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  var userSnap1;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('pots')
          .where('uid', isEqualTo: widget.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (e) {
      showSnackbar(context, kblackcolor, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthMethods authMethods = AuthMethods();
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Stack(children: [
            const SizedBox(
              width: double.infinity,
              height: 250,
              child: Image(
                  fit: BoxFit.cover, image: AssetImage(knullimagebaground)),
              //color: Colors.amber,
            ),
            FirebaseAuth.instance.currentUser!.uid == widget.uid
                ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: IconButtonWidgets(
                            icon: const Icon(Icons.settings),
                            ontap1: () {
                              Get.to(SettingsScreen(
                                  userName: userData['username']));
                            }))
                  ])
                : Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: IconButtonWidgets(
                            icon: const Icon(Icons.arrow_back),
                            ontap1: () {
                              Get.back();
                            }))
                  ]),
            Center(
                heightFactor: 1.7,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: kprofileContainercolor),
                    width: 400,
                    height: 600,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 20),
                                child: TextFollowersWidgets(
                                    followers: followers.toString(),
                                    name: 'Followers',
                                    click: () {
                                      Get.to(const ScreenFollowers());
                                    })),
                            const Spacer(),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, right: 20),
                                child: TextFollowersWidgets(
                                    followers: following.toString(),
                                    name: 'Following',
                                    click: () {
                                      Get.to(const ScreenFollowers());
                                    }))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('@_${userData['username']}',
                                style: const TextStyle(color: kblackcolor))
                          ]),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                                'My name is Amal kvs and this ma future\n app ,now iam developing this ui.',
                                style: TextStyle(fontSize: 11.5))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? FollowButton(
                                    backgroundColor: kblackcolor,
                                    borderColor: kwhitecolor,
                                    text: 'Lotgg Out',
                                    textColor: kwhitecolor,
                                    function: () {
                                      authMethods.signOut();

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                          (route) => false);
                                    },
                                  )
                                : isFollowing
                                    ? Row(
                                        children: [
                                          FollowButton(
                                            backgroundColor: kblackcolor,
                                            borderColor: kwhitecolor,
                                            text: 'Unfollow',
                                            textColor: kwhitecolor,
                                            function: () async {
                                              await FireStoreMethods()
                                                  .followUser(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      userData['uid']);
                                              setState(() {
                                                isFollowing = false;
                                                followers--;
                                              });
                                            },
                                          ),
                                          IconButtonWidgets(
                                              ontap1: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                                snap: model
                                                                        .UserModel
                                                                    .fromSnap(widget
                                                                        .snap
                                                                        .data))));
                                              },
                                              icon: const Icon(Icons.message))
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          FollowButton(
                                            backgroundColor: kblackcolor,
                                            borderColor: kwhitecolor,
                                            text: 'Follow',
                                            textColor: kwhitecolor,
                                            function: () async {
                                              await FireStoreMethods()
                                                  .followUser(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      userData['uid']);
                                              setState(() {
                                                isFollowing = true;
                                                followers++;
                                              });
                                            },
                                          ),
                                          IconButtonWidgets(
                                              ontap1: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                              snap: model
                                                                      .UserModel
                                                                  .fromSnap(
                                                                      widget
                                                                          .snap
                                                                          .data),
                                                            )));
                                              },
                                              icon: const Icon(Icons.message))
                                        ],
                                      ),
                          ]),
                      const SizedBox(height: 20),
                      Expanded(
                          child: PostsBuilderWidjet(uid: widget.uid.toString()))

                      // bottom:
                    ]))),
            Center(
                heightFactor: 4.25,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(userData['photoUrl'])),
                        border: Border.all(width: 5, color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black),
                    width: 100,
                    height: 100))
          ]);
  }
} 

// ignore: must_be_immutable

