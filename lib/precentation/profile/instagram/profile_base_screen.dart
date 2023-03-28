import 'package:flutter/material.dart';

Widget profileHeaderWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xff74EDED),
                  backgroundImage:
                      AssetImage('lib/precentation/assets/IMG_4615.jpg')),
              Row(
                children: [
                  Column(
                    children: const [
                      Text(
                        "23",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Posts",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.4,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: const [
                      Text(
                        "1.5M",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: const [
                      Text(
                        "234",
                        style: TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(
                          letterSpacing: 0.4,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Amal kvs",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "The developer",
            style: TextStyle(
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          actions(context),
          const SizedBox(
            height: 20,
          ),
          // Container(
          //   height: 85,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: highlightItems.length,
          //     itemBuilder: (context, index) {
          //       return Row(
          //         children: [
          //           Column(
          //             children: [
          //               CircleAvatar(
          //                 radius: 30,
          //                 backgroundColor: Colors.grey,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(2.0),
          //                   child: CircleAvatar(
          //                     backgroundImage:
          //                         AssetImage(highlightItems[index].thumbnail),
          //                     radius: 28,
          //                   ),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 4),
          //                 child: Text(
          //                   highlightItems[index].title,
          //                   style: TextStyle(fontSize: 13),
          //                 ),
          //               )
          //             ],
          //           ),
          //           SizedBox(
          //             width: 10,
          //           )
          //         ],
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    ),
  );
}

Widget actions(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: OutlinedButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text("Edit Profile", style: TextStyle(color: Colors.black)),
          ),
          style: OutlinedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(0, 30),
              side: const BorderSide(
                color: Colors.grey,
              )),
          onPressed: () {},
        ),
      ),
    ],
  );
}
