import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/Application/untill.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String senderId;
  final String recieverId;
  final String recieverAvatarUrl;
  final String recieverUsername;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.senderId,
    required this.recieverId,
    required this.recieverAvatarUrl,
    required this.recieverUsername,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(DocumentSnapshot? jsonq) {
    var json = jsonq?.data() as Map<String, dynamic>;
    return Message(
      senderId: json['senderId'],
      recieverId: json['recieverId'],
      recieverAvatarUrl: json['recieverAvatarUrl'],
      recieverUsername: json['recieverUsername'],
      message: json['message'],
      createdAt: Utils.toDateTime(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'recieverId': recieverId,
        'recieverAvatarUrl': recieverAvatarUrl,
        'recieverUsername': recieverUsername,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
