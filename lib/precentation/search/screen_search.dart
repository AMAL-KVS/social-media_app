import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/profile/screen_profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isUsers = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kwhitecolor,
            toolbarHeight: 70,
            title: Column(children: [
              TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Search Here ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  controller: searchcontroller,
                  onChanged: ((val) {
                    setState(() {
                      searchcontroller.text = val;
                      isUsers = true;
                    });
                  }))
            ]),
            actions: [
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      searchcontroller.clear();
                      isUsers = false;
                    });
                  })
            ],
            centerTitle: true),
        body: isUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username',
                        isGreaterThanOrEqualTo: searchcontroller.text)
                    .get(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['photoUrl']),
                              radius: 16,
                            ),
                            title: Text((snapshot.data! as dynamic).docs[index]
                                ['username']));
                      }));
                }))
            : FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('datePublished')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2),
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ProfileBaseScreen(
                                    uid: (snapshot.data! as dynamic).docs[index]
                                        ['uid'])));
                          },
                          child: Container(
                              color: kblackcolor,
                              width: 70,
                              height: 70,
                              child: Image.network(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['postUrl'],
                                  fit: BoxFit.cover)),
                        );
                      },
                      itemCount: (snapshot.data! as dynamic).docs.length);
                }));
  }
}
