import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/widgets/icon_button_widgets.dart';

class SessionThree extends StatelessWidget {
  const SessionThree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://myanimelist.net/images/userimages/6371992.jpg?t=1645461000'))),
              width: double.infinity,
              height: 550,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(knullimage),
                      ),
                      kwidth10,
                      const Text(
                        'User name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButtonWidgets(
                          icon: const Icon(
                            Icons.menu,
                            color: kwhitecolor,
                          ),
                          ontap1: () {})
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 410),
                    child: Card(
                      child: ListTile(
                          leading: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border)),
                          trailing: IconButton(
                              icon: const Icon(Icons.share), onPressed: () {})),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
