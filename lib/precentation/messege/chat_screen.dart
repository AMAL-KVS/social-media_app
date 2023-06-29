import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:social_media/Application/chat_model.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/Application/user_model.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/messege/widgets/messege_view.dart';
import 'package:social_media/precentation/messege/widgets/messsege_sent_feild.dart';
import 'package:social_media/precentation/profile/screen_profile.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  UserModel snap;
  ChatScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    log(FirebaseAuth.instance.currentUser!.displayName.toString());
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context);
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: yourAppID /*input your AppID*/,
      appSign: yourAppSign /*input your AppSign*/,
      userID: user.getUser.uid,
      userName: user.getUser.username,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhitecolor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ProfileBaseScreen(uid: widget.snap.uid);
                    },
                  ));
                },
                child: Text(
                  widget.snap.username.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )),
            const SizedBox(height: 2),
            // snap.status == 'online'
            //     ? const Row(
            //         children: [
            //           Text(
            //             ' Online',
            //             style: TextStyle(fontSize: 13),
            //           ),
            //           SizedBox(width: 4),
            //           CircleAvatar(
            //             radius: 5,
            //             backgroundColor: Colors.green,
            //           )
            //         ],
            //       )
            //     : const Row(
            //         children: [
            //           Text(
            //             'Offline',
            //             style: TextStyle(fontSize: 13),
            //           ),
            //           SizedBox(width: 4),
            //           CircleAvatar(
            //             radius: 5,
            //             backgroundColor: Colors.red,
            //           )
            //         ],
            //       )
          ],
        ),
        actions: [
          SizedBox(
            width: 600,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 35, width: 35, child: actionButton(false)),
                        SizedBox(
                            height: 35, width: 35, child: actionButton(true)),
                        // CircleIconBack(
                        //   index: 1,
                        //   icon: phn,
                        // )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          //message view
          Expanded(
              child: Container(
            child: MessageViewWidget(idUser: widget.snap.uid),
          )),
          //messaage sending field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SentNewMessageTextField(
                snap: widget.snap, currentUser: user.getUser),
          ),
        ],
      ),
    );
  }

  ZegoSendCallInvitationButton actionButton(bool isVideo) {
    log('zego works');
    return ZegoSendCallInvitationButton(
      notificationMessage: 'incoming call',
      notificationTitle: widget.snap.username,
      iconTextSpacing: 0.0,
      iconSize: const Size(35, 35),
      isVideoCall: isVideo,
      callID: '12',
      invitees: [
        ZegoUIKitUser(id: widget.snap.uid, name: widget.snap.username)
      ],
    );
  }
}
