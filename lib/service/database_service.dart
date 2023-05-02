import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

// class DatabaseService {
//   final String? uid;
//   DatabaseService({this.uid});
// //reference for our collection
//   final CollectionReference userColloection =
//       FirebaseFirestore.instance.collection("users");
//   final CollectionReference groupColloection =
//       FirebaseFirestore.instance.collection("groups");

// //updating the userdata
//   Future savingUserData(String userName, String email) async {
//     return await userColloection.doc(uid).set({
//       "userName": userName,
//       "email": email,
//       "gropus": [],
//       "profilePic": "",
//       "uid": uid
//     });
//   }

//   //getting the user data

//   Future gettingTheUserData(String email) async {
//     QuerySnapshot snapshot =
//         await userColloection.where("email", isEqualTo: email).get();
//     return snapshot;
//   }

//   //get user grups
//   getUserGrups() async {
//     return userColloection.doc(uid).snapshots();
//   }

//   //creating grupd
//   Future creatingGruop(String username, String id, String groupName) async {
//     DocumentReference groupDocumentReference = await groupColloection.add({
//       "groupName": groupName,
//       "groupIcon": "",
//       "admin": "${id} _$username",
//       "members": [],
//       "groupId": "",
//       "recentMessege": "",
//       "recentMessegeSenter": "",
//     });
// //updatein the members
//     await groupDocumentReference.update({
//       "members": FieldValue.arrayUnion(["${uid}_$username"]),
//       "groupId": groupDocumentReference.id,
//     });

//     DocumentReference userDocumnetReference = userColloection.doc(uid);

//     return await userDocumnetReference.update({
//       "groups":
//           FieldValue.arrayUnion(["${userDocumnetReference.id}_$groupName"])
//     });
//   }
// }

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
