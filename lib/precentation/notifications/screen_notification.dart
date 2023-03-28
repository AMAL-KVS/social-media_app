import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/messege/widgets/screen_chat.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  subtitle: const Text('Active Now'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const ChatScreen())));
                  },
                  leading: const CircleAvatar(
                    radius: 40,
                    backgroundColor: kblackcolor,
                    backgroundImage: NetworkImage(knullimage),
                  ),
                  title: const Text('User Name',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            }));
  }
}
