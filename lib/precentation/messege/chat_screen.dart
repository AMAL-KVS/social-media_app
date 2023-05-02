import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/Application/user_model.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/messege/widgets/messege_view.dart';
import 'package:social_media/precentation/messege/widgets/messsege_sent_feild.dart';
import 'package:social_media/precentation/profile/screen_profile.dart';

class ChatScreen extends StatelessWidget {
  UserModel snap;
  ChatScreen({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

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
                      return ProfileBaseScreen(uid: snap.uid);
                    },
                  ));
                },
                child: Text(
                  snap.username.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w400),
                )),
            const SizedBox(height: 2),
            // snap.status == 'online'
            //     ? Row(
            //         children: const [
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
            //     :
            Row(
              children: const [
                Text(
                  'Offline',
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(width: 4),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          //message view
          Expanded(
              child: Container(
            child: MessageViewWidget(idUser: snap.uid),
          )),
          //messaage sending field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SentNewMessageTextField(snap: snap, currentUser: user),
          ),
        ],
      ),
    );
  }
}
