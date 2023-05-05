import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/core/constants/constands.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    final data = userProvider.getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kwhitecolor,
          title: const Text('Accound '),
        ),
        body: Column(children: [
          kheight10,
          Center(
            child: CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(data.photoUrl.toString()),
              backgroundColor: kwhitecolor,
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: Card(
                  color: Colors.white,
                  child: ListTile(
                      title: Text(data.username,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('user name'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.lightBlueAccent)))),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: Card(
                  color: Colors.white,
                  child: ListTile(
                      title: Text(data.bio,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('bio'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.lightBlueAccent)))),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: Card(
                  color: Colors.white,
                  child: ListTile(
                      title: Text(data.email,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('Email'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.lightBlueAccent)))),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: Card(
                  color: Colors.white,
                  child: ListTile(
                      title: Text(data.status,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('Stus'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.lightBlueAccent))))
        ]));
  }
}
