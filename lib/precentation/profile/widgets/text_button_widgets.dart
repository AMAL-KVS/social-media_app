import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';

// ignore: must_be_immutable
class TextFollowersWidgets extends StatelessWidget {
  String followers;
  String name;
  void Function()? click;

  TextFollowersWidgets(
      {Key? key,
      required this.followers,
      required,
      required this.name,
      required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: click,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(followers,
              style: const TextStyle(
                  color: kblackcolor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Text(name,
              style: const TextStyle(
                  color: kblackcolor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))
        ]));
  }
}
