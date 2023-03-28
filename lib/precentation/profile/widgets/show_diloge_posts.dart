import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/Application/post_model.dart';
import 'package:social_media/Application/user_model.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/helper/helper_function.dart';
import 'package:social_media/precentation/profile/widgets/text_button_widgets.dart';
import 'package:social_media/precentation/settings/screen_settings.dart';
import 'package:social_media/widgets/icon_button_widgets.dart';
import 'package:uuid/uuid.dart';

import '../followers/screen_followers.dart';

final currentemail = FirebaseAuth.instance.currentUser!.email;
Future<void> _showAlertDialog(BuildContext context) async {
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
                child: const SizedBox(
                    child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(knullimageProfile)))));
      });
}

class ProfileStackWIdgets extends StatefulWidget {
  const ProfileStackWIdgets({Key? key}) : super(key: key);

  @override
  State<ProfileStackWIdgets> createState() => _ProfileStackWIdgetsState();
}

class _ProfileStackWIdgetsState extends State<ProfileStackWIdgets> {
  String email = "";
  String userName = "";
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
    return Stack(children: [
      const SizedBox(
        child: Image(fit: BoxFit.cover, image: AssetImage(knullimagebaground)),
        //color: Colors.amber,
        width: double.infinity,
        height: 250,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButtonWidgets(
                icon: const Icon(Icons.settings),
                ontap1: () {
                  Get.to(SettingsScreen(userName: userName));
                }),
          ),
        ],
      ),
      Center(
          heightFactor: 1.7,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: kprofileContainercolor),
              width: 400,
              height: 600,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: TextFollowersWidgets(
                        followers: '1.3 M',
                        name: 'Followers',
                        click: () {
                          Get.to(const ScreenFollowers());
                        },
                      )),
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      child: TextFollowersWidgets(
                          followers: '10',
                          name: 'Following',
                          click: () {
                            Get.to(const ScreenFollowers());
                          }))
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('@_$userName',
                        style: const TextStyle(
                          color: kblackcolor,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                          'My name is Amal kvs and this ma future\n app ,now iam developing this ui.',
                          style: TextStyle(fontSize: 11.5))
                    ]),
                const SizedBox(height: 20),
                Expanded(child: PostsBuilderWidjet())

                // bottom:
              ]))),
      Center(
          heightFactor: 4.25,
          child: Container(
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(knullimageProfile)),
                  border: Border.all(width: 5, color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black),
              width: 100,
              height: 100))
      // TabBar(
      //     isScrollable: true,
      //     controller: tabController,
      //     tabs: const [
      //       Tab(icon: Icon(Icons.image, color: Colors.black)),
      //       Tab(icon: Icon(Icons.camera, color: Colors.black)),
      //       Tab(icon: Icon(Icons.tag, color: Colors.black)),
      //     ]),
      // TabBarView(controller: tabController, children: [
      //   Container(),
      //   Container(),
      //   Container(),
      // ])
    ]);
  }
}

// ignore: must_be_immutable
class PostsBuilderWidjet extends StatelessWidget {
  final postRef = FirebaseFirestore.instance.collection('posts');
  String email = "";

  String? postId;
  String? ownerId;
  String? userName;
  String? location;
  String? discription;
  String? mediaUrl;
  String? likes;

  PostsBuilderWidjet(
      {Key? key,
      this.discription,
      this.likes,
      this.location,
      this.mediaUrl,
      this.ownerId,
      this.postId,
      this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String postId = const Uuid().v4();
    return StreamBuilder<List<PostModel>>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(currentemail)
            .collection(currentemail.toString())
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((e) => PostModel.fromJson(e.data()))
                .toList()),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                      onLongPress: () {
                        _showAlertDialog(context);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.amber,
                          child: Image(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(snapshot.data![0].mediaUrl))));
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }

  // getPosts() {
  //   postRef.doc(profileId);
  // }
}
