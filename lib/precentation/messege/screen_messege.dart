import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/messege/widgets/screen_chat.dart';

class MessegeScreen extends StatelessWidget {
  const MessegeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kwhitecolor,
          title: const Text(
            'Chats..',
            style: TextStyle(color: kblackcolor),
          ),
        ),
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
                      backgroundImage: NetworkImage(knullimage)),
                  title: const Text('User Name',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.camera_alt)),
                ),
              );
            }));
  }
}
