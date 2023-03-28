import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';

class SighnUpScreen extends StatelessWidget {
  const SighnUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              AlertDialog(
                title: Text('show  '),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'HI',
                  style: TextStyle(color: kblackcolor),
                ),
                Text(
                  'HI',
                  style: TextStyle(color: kblackcolor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
