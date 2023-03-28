import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  String id;
  final String name;
  final String userName;
  final String email;

  UserDetails(
      {this.id = '',
      required this.name,
      required this.userName,
      required this.email});

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'userName': userName, 'email': email};

  static UserDetails fromJson(Map<String, dynamic> json) => UserDetails(
        email: json['email'],
        name: json['name'],
        userName: json['userName'],
        id: json['id'],
      );
  static fromDocument(DocumentSnapshot doc) {
    return UserDetails(
        name: doc['name'],
        userName: doc['userName'],
        email: doc['email'],
        id: doc['id']);
  }
}
