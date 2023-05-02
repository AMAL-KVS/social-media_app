// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/Application/provider.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/helper/image_picker.dart';
import 'package:social_media/service/firestore_methods.dart';

class NewPostsScreen extends StatefulWidget {
  const NewPostsScreen({Key? key}) : super(key: key);

  @override
  State<NewPostsScreen> createState() => _NewPostsScreenState();
}

class _NewPostsScreenState extends State<NewPostsScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  void addPost(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kwhitecolor,
          elevation: 0,
          toolbarHeight: 80,
          centerTitle: true,
          title:
              const Text('Create a Post', style: TextStyle(color: kblackcolor)),
          actions: [
            IconButton(
                onPressed: () {
                  addPost(
                      userProvider.getUser.uid,
                      userProvider.getUser.username,
                      userProvider.getUser.photoUrl);
                },
                icon: const Icon(Icons.post_add, color: kblackcolor))
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
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
                  _file == null
                      ? const Center(
                          child: Text('Post some'),
                        )
                      : imageContainer(_file, context),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 150),
                      child: TextField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(hintText: 'New post....'))),
                  ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text('Add A Phooto'),
                      onTap: () async {
                        Uint8List file = await pickImage(ImageSource.gallery);
                        setState(() {
                          _file = file;
                        });
                      }),
                  // const ListTile(
                  //     leading: Icon(Icons.video_call),
                  //     title: Text('Add A Video')),
                  // const ListTile(
                  //     leading: Icon(Icons.broadcast_on_home_sharp),
                  //     title: Text('Quick Live')),
                  // const ListTile(
                  //     leading: Icon(Icons.text_fields_outlined),
                  //     title: Text('Add A Text')),
                ],
              ));
  }

  Container imageContainer(imageLink, context) {
    return Container(
        // height: 400,
        // width: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: MemoryImage(imageLink!))));
  }
}
