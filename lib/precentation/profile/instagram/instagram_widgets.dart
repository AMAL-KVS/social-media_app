// import 'package:flutter/material.dart';
// import 'package:social_media/precentation/newposts/screen_new_posts.dart';
// import 'package:social_media/precentation/profile/widgets/profile_base_screen.dart';
// import 'package:social_media/precentation/profile/widgets/tab_gallery.dart';
// import 'package:social_media/precentation/profile/widgets/tab_igtv.dart';
// import 'package:social_media/precentation/profile/widgets/tab_reel.dart';

// class ProfileBaseScreen extends StatefulWidget {
//   @override
//   _ProfileBaseScreenState createState() => _ProfileBaseScreenState();
// }

// class _ProfileBaseScreenState extends State<ProfileBaseScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(40),
//         child: Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             title: const Text(
//               "Amal kvs",
//               style:
//                   TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//             ),
//             centerTitle: false,
//             elevation: 0,
//             actions: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.add_box_outlined,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (ctx) => const NewPostsScreen()));
//                 },
//               ),
//               IconButton(
//                   icon: const Icon(
//                     Icons.menu,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {
//                     const Drawer();
//                   })
//             ],
//           ),
//         ),
//       ),
//       body: DefaultTabController(
//         length: 3,
//         child: NestedScrollView(
//           headerSliverBuilder: (context, _) {
//             return [
//               SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     profileHeaderWidget(context),
//                   ],
//                 ),
//               ),
//             ];
//           },
//           body: Column(
//             children: <Widget>[
//               Material(
//                 color: Colors.white,
//                 child: TabBar(
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey[400],
//                   indicatorWeight: 1,
//                   indicatorColor: Colors.black,
//                   tabs: [
//                     const Tab(
//                       icon: Icon(
//                         Icons.grid_on_sharp,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Tab(
//                       icon: Image.asset(
//                           'lib/precentation/assets/IGTV-Logo-PNG-Image.png',
//                           height: 30,
//                           width: 30),
//                     ),
//                     Tab(
//                       icon: Image.asset(
//                           'lib/precentation/assets/instagram-reels-icon.webp',
//                           height: 25,
//                           width: 25),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     Gallery(),
//                     const Igtv(),
//                     const Reels(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<StatefulWidget> createState() => AnimatedDialogState();
}

class AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));

    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black.withOpacity(opacityAnimation.value),
        child: Center(
            child: FadeTransition(
                opacity: scaleAnimation,
                child: ScaleTransition(
                    scale: scaleAnimation, child: widget.child))));
  }
}
