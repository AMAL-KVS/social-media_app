import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';

class StoryContainer extends StatelessWidget {
  const StoryContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: kblackcolor,
              backgroundImage: NetworkImage(knullimage),
            ),
          );
        },
      ),
    );
  }
}
