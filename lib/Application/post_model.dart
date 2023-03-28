class PostModel {
  final String postid;
  final String mediaUrl;
  final String ownerid;
  final String postMessege;

  PostModel(
      {required this.postid,
      required this.mediaUrl,
      required this.ownerid,
      required this.postMessege});

  // static fromJ(DocumentSnapshot doc) {
  //   return PostModel(
  //       postid: doc['postid'],
  //       mediaUrl: doc['mediaUrl'],
  //       ownerid: doc['ownerid'],
  //       postMessege: doc['postMessege']);
  // }

  Map<String, dynamic> toJson() => {
        'postId': postid,
        'mediaUrl': mediaUrl,
        'ownerid': ownerid,
        'postMessege': postMessege
      };
//  static PostModel.fromJson(Map<String,dynamic>json)=>PostModel{

// return PostModel(
//         postid:json ['postid'],
//         mediaUrl: json['mediaUrl'],
//         ownerid: json['ownerid'],
//         postMessege: json['postMessege']);

// }
  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
      postid: json['postid'],
      mediaUrl: json['mediaUrl'],
      ownerid: json['ownerid'],
      postMessege: json['postMessege']);
}
