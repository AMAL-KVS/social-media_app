import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/Login/ponenumber/phone_number_screen.dart';
import 'package:social_media/precentation/profile/screen_profile.dart';
import 'package:social_media/precentation/profile/widgets/show_diloge_posts.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;

List gallery = [];

class NewPostsScreen extends StatefulWidget {
  NewPostsScreen({Key? key}) : super(key: key);

  @override
  State<NewPostsScreen> createState() => _NewPostsScreenState();
}

class _NewPostsScreenState extends State<NewPostsScreen> {
  File? file;

  String postId = const Uuid().v4();

  bool isloadin = false;

  TextEditingController postMessegeController = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();

  final postRef = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kwhitecolor,
          elevation: 0,
          toolbarHeight: 80,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kblackcolor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          centerTitle: true,
          title:
              const Text('Create a Post', style: TextStyle(color: kblackcolor)),
          actions: [
            IconButton(
                onPressed: () async {
                  await compresImage();
                  String mediaUrl = await uploadImage(file);
                  createPostInFireBase(
                      mediaUrl: mediaUrl,
                      postMessege: postMessegeController.text);
                  file = null;
                  postMessegeController.clear();
                  postId = const Uuid().v4();
                  Get.back();
                },
                icon: const Icon(Icons.post_add, color: kblackcolor))
          ],
        ),
        body: ListView(
          children: [
            Row(
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: kblackcolor,
                  backgroundImage: NetworkImage(knullimage),
                ),
                kwidth10,
                Text(
                  'User Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            file == null
                ? const SizedBox()
                : isloadin == true
                    ? const Center(
                        child: CircularProgressIndicator(color: kblackcolor),
                      )
                    : Container(
                        height: 400,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: FileImage(file!))),
                      ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: TextField(
                controller: postMessegeController,
                decoration: const InputDecoration(hintText: 'New post....'),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Add A Phooto'),
                onTap: () async {
                  await pickImageForPost();
                  if (file == null) {
                    setState(() {
                      isloadin = true;
                    });
                  } else {
                    setState(() {
                      isloadin = false;
                    });
                  }
                  log(file.toString());
                }),
            const ListTile(
                leading: Icon(Icons.video_call), title: Text('Add A Video')),
            const ListTile(
                leading: Icon(Icons.broadcast_on_home_sharp),
                title: Text('Quick Live')),
            const ListTile(
                leading: Icon(Icons.text_fields_outlined),
                title: Text('Add A Text')),
          ],
        ));
  }

//pick image from gallery
  pickImageForPost() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    File fileType = File(file!.path);
    this.file = fileType;
  }

//compress image
  compresImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file!.readAsBytesSync())!;
    final compresedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    file = compresedImageFile;
  }

//upload image
  Future<String> uploadImage(imageFile) async {
    final uploadTask = storageRef.child("post_$postId.jpg").putFile(imageFile);
    final storageSnap = await uploadTask.whenComplete(() => null);
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  //create post by user
  createPostInFireBase({required String mediaUrl, required postMessege}) {
    postRef
        .doc(currentemail)
        .collection(currentemail.toString())
        .doc(postId)
        .set({
      "postId": postId,
      "ownerid": ScreenPhoneNumber.phoneNumber,
      "mediaUrl": mediaUrl,
      "postMessege": postMessege
    });
    FirebaseFirestore.instance.collection('home').doc().set({
      "postId": postId,
      "ownerid": ScreenPhoneNumber.phoneNumber,
      "mediaUrl": mediaUrl,
      "postMessege": postMessege
    });
  }
}
