import 'package:cloud_firestore/cloud_firestore.dart';

// class PostModel {
//   final String doc;
//   //final String postid;
//   final String mediaUrl;
//   final String ownerid;
//   final String postMessege;

//   PostModel(
//       {required this.doc,
//       //required this.postid,
//       required this.mediaUrl,
//       required this.ownerid,
//       required this.postMessege});

//   Map<String, dynamic> toJson() => {
//         'doc': doc,
//         //'postId': postid,
//         'mediaUrl': mediaUrl,
//         'ownerid': ownerid,
//         'postMessege': postMessege
//       };

//   static PostModel fromJson(Map<String, dynamic> json) => PostModel(
//       doc: json['doc'],
//       // postid: json['postid'],
//       mediaUrl: json['mediaUrl'],
//       ownerid: json['ownerid'],
//       postMessege: json['postMessege']);
// }
// static fromJ(DocumentSnapshot doc) {
//   return PostModel(
//       postid: doc['postid'],
//       mediaUrl: doc['mediaUrl'],
//       ownerid: doc['ownerid'],
//       postMessege: doc['postMessege']);
// }

//  static PostModel.fromJson(Map<String,dynamic>json)=>PostModel{

// return PostModel(
//         postid:json ['postid'],
//         mediaUrl: json['mediaUrl'],
//         ownerid: json['ownerid'],
//         postMessege: json['postMessege']);

// }

class PostsModel {
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const PostsModel({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  static PostsModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostsModel(
        description: snapshot["description"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}
