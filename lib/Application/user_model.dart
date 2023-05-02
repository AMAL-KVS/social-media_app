import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/Application/untill.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final DateTime? lastMessageTime;
  final String status;

  const UserModel(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following,
      required this.lastMessageTime,
      required this.status});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        username: snapshot["username"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        photoUrl: snapshot["photoUrl"],
        bio: snapshot["bio"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        lastMessageTime: Utils.toDateTime(snapshot['lastMessageTime']),
        status: snapshot['status']);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
        'status': status
      };
}

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}
