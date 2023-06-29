// import 'package:flutter/material.dart';
// import 'package:social_media/core/constants/constands.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class CallPage extends StatelessWidget {
//   CallPage({Key? key, required this.userId, required this.userName})
//       : super(key: key);

//   final String userId;
//   final String userName;

//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID:
//           yourAppID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//       appSign:
//           yourAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//       userID: userId,
//       userName: userName,
//       callID: '12',
//       // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//         ..onOnlySelfInRoom = (ctx) => Navigator.of(context).pop(),
//     );
//   }
// }
