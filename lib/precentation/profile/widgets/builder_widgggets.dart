import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/precentation/profile/instagram/instagram_widgets.dart';

// ignore: must_be_immutable
class PostsBuilderWidjet extends StatefulWidget {
  final String uid;

  const PostsBuilderWidjet({Key? key, required this.uid}) : super(key: key);

  @override
  State<PostsBuilderWidjet> createState() => _PostsBuilderWidjetState();
}

class _PostsBuilderWidjetState extends State<PostsBuilderWidjet> {
  final postRef = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    late OverlayEntry _popupDialog;
    //String postId = const Uuid().v4();
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: widget.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('No Data'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (ctx, index) {
                DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                return GestureDetector(
                    onLongPress: () {
                      _popupDialog = createPopupDialog(snap['postUrl']);
                      Overlay.of(context).insert(_popupDialog);
                    },
                    onLongPressEnd: (details) => _popupDialog.remove(),
                    child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(snap['postUrl']))));
              });
        });
  }
}

Widget _createPopupContent(String url) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(child: Image.network(url, fit: BoxFit.fitWidth)),
      ),
    );
OverlayEntry createPopupDialog(String url) {
  return OverlayEntry(
      builder: (context) => AnimatedDialog(child: _createPopupContent(url)));
}
