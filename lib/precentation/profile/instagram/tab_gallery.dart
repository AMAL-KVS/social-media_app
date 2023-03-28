// import 'package:flutter/material.dart';
// import 'package:social_media/precentation/profile/screen_profile.dart';
// import 'package:social_media/precentation/profile/widgets/instagram_widgets.dart';

// class Gallery extends StatefulWidget {
//   @override
//   _GalleryState createState() => _GalleryState();
// }

// class _GalleryState extends State<Gallery> {
//   late OverlayEntry _popupDialog;
//   List<String> imageUrls = [
//     'lib/precentation/assets/20220828_142150.jpg',
//     'lib/precentation/assets/20230106_120958.jpg',
//     'lib/precentation/assets/1662885359390.jpg',
//     'lib/precentation/assets/DSC_0399.jpg',
//     'lib/precentation/assets/DSC_0498.jpg',
//     'lib/precentation/assets/DSC_0809 (1).jpg',
//     'lib/precentation/assets/IMG_4615.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.count(
//         crossAxisCount: 3,
//         childAspectRatio: 1.0,
//         children: imageUrls.map(_createGridTileWidget).toList(),
//       ),
//     );
//   }

//   Widget _createGridTileWidget(String url) => Builder(
//         builder: (context) => GestureDetector(
//           onLongPress: () {
//             _popupDialog = _createPopupDialog(url);
//             Overlay.of(context)!.insert(_popupDialog);
//           },
//           onLongPressEnd: (details) => _popupDialog.remove(),
//           child: Image.asset(url, fit: BoxFit.cover),
//         ),
//       );

//   OverlayEntry _createPopupDialog(String url) {
//     return OverlayEntry(
//       builder: (context) => AnimatedDialog(
//         child: _createPopupContent(url),
//       ),
//     );
//   }

//   Widget _createPhotoTitle() => Container(
//       width: double.infinity,
//       color: Colors.white,
//       child: const ListTile(
//         leading: CircleAvatar(
//             backgroundImage:
//                 AssetImage('lib/precentation/assets/IMG_4615.jpg')),
//         title: Text('Amal kvs',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
//       ));

//   Widget _createActionBar() => Container(
//         padding: const EdgeInsets.symmetric(vertical: 10.0),
//         color: Colors.white,
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: const [
//               Icon(
//                 Icons.favorite_border,
//                 color: Colors.black,
//               ),
//               Icon(
//                 Icons.chat_bubble_outline_outlined,
//                 color: Colors.black,
//               ),
//               Icon(
//                 Icons.send,
//                 color: Colors.black,
//               )
//             ]),
//       );

//   Widget _createPopupContent(String url) => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _createPhotoTitle(),
//               Image.asset(url, fit: BoxFit.fitWidth),
//               _createActionBar(),
//             ],
//           ),
//         ),
//       );
// }
