import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Application/user_model.dart';
import 'package:social_media/helper/image_picker.dart';
import 'package:social_media/service/firebase_messeging.dart';

class SentNewMessageTextField extends StatefulWidget {
  UserModel snap;
  UserModel? currentUser;
  SentNewMessageTextField({
    required this.snap,
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<SentNewMessageTextField> createState() =>
      _SentNewMessageTextFieldState();
}

class _SentNewMessageTextFieldState extends State<SentNewMessageTextField> {
  String messages = '';
  final _textController = TextEditingController();

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    //upload message
    await FirebaseApi.uploadMessage(
      currentUserId: widget.currentUser!.uid,
      recieverId: widget.snap.uid,
      message: messages,
      recieverAvatarUrl: widget.snap.photoUrl,
      recieverUsername: widget.snap.username,
    );

    //
    _textController.clear();
    messages = '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: _textController,
          onChanged: (value) {
            setState(() {
              messages = value;
            });
          },
          autocorrect: true,
          enableSuggestions: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Type your message....',
            filled: true,
            fillColor: Colors.grey[400],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 15, color: Colors.black),
                gapPadding: 10),
          ),
        )),
        SizedBox(width: 5),
        InkWell(
          onTap: () async {
            messages.trim().isEmpty
                ? showSnackBar(context, 'Type some message to sent!')
                : sendMessage();
          },
          child: CircleAvatar(
            backgroundColor:
                messages.trim().isEmpty ? Colors.grey : Colors.black,
            radius: 24,
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}
