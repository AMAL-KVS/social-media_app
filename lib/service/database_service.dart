import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
//reference for our collection
  final CollectionReference userColloection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupColloection =
      FirebaseFirestore.instance.collection("groups");

//updating the userdata
  Future savingUserData(String userName, String email) async {
    return await userColloection.doc(uid).set({
      "userName": userName,
      "email": email,
      "gropus": [],
      "profilePic": "",
      "uid": uid
    });
  }

  //getting the user data

  Future gettingTheUserData(String email) async {
    QuerySnapshot snapshot =
        await userColloection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //get user grups
  getUserGrups() async {
    return userColloection.doc(uid).snapshots();
  }

  //creating grupd
  Future creatingGruop(String username, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupColloection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id} _$username",
      "members": [],
      "groupId": "",
      "recentMessege": "",
      "recentMessegeSenter": "",
    });
//updatein the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$username"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumnetReference = userColloection.doc(uid);

    return await userDocumnetReference.update({
      "groups":
          FieldValue.arrayUnion(["${userDocumnetReference.id}_$groupName"])
    });
  }
}
