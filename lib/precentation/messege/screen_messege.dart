import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/messege/chat_screen.dart';
import 'package:social_media/precentation/messege/widgets/chat_head_widgets.dart';
import 'package:social_media/Application/user_model.dart' as model;
import 'package:social_media/widgets/image_alert_view.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: Column(children: [
      //chat head view
      Container(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          height: 100,
          child: const ChatHeaderWidjet()),

      //recently texted list view
      Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: kwhitecolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .orderBy('lastMessageTime', descending: true)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.docs[index]['uid'] ==
                              currentUser.uid) {
                            return const SizedBox();
                          }

                          return Padding(
                              padding: const EdgeInsets.all(3.5),
                              child: InkWell(
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (builder) {
                                          return ImageAlertView(
                                            isProfile: true,
                                            imageUrl: snapshot.data!.docs[index]
                                                ['photoUrl'],
                                          );
                                        });
                                  },
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                snap: model.UserModel.fromSnap(
                                                    snapshot
                                                        .data!.docs[index]))));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.5),
                                        child: ListTile(
                                            leading: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['photoUrl'])),
                                            title: Text(
                                              snapshot.data!.docs[index]
                                                  ['username'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 8,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            trailing: CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    snapshot.data!.docs[index]
                                                                ['status'] ==
                                                            'online'
                                                        ? Colors.green
                                                        : Colors.red)),
                                      ))));
                        });
                  })))
    ]));
  }
}
