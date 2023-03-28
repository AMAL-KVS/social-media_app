import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';

class ScreenFollowers extends StatelessWidget {
  const ScreenFollowers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 10,
            bottom: const TabBar(tabs: [
              Tab(text: 'Mutual'),
              Tab(text: 'Followers'),
              Tab(text: 'Following')
            ])),
        body: const TabBarView(
          children: [
            FollowersBuilderWidgets(),
            FollowersBuilderWidgets(),
            FollowersBuilderWidgets(),
          ],
        ),
      ),
    );
  }
}

class FollowersBuilderWidgets extends StatelessWidget {
  const FollowersBuilderWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, _) {
          return ListTile(
              style: ListTileStyle.drawer,
              leading: const CircleAvatar(
                backgroundImage: AssetImage(knullimageProfile),
              ),
              title: const Text('Username'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Follow'),
              ));
        });
  }
}
