import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageAlertView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final imageUrl;
  bool isProfile;
  ImageAlertView({Key? key, required this.isProfile, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: isProfile
          ? CircleAvatar(
              radius: 130,
              backgroundColor: Colors.grey[400],
              backgroundImage: CachedNetworkImageProvider(imageUrl))
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 500,
                width: 450,
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'lib/model/assets/placeholder_for_homepost.jpg'),
                          fit: BoxFit.cover)),
                ),
                errorWidget: (context, url, error) => Column(
                  children: const [
                    Icon(
                      Icons.error,
                      size: 30,
                      color: Colors.red,
                    ),
                    Text('NO NETWORK !!')
                  ],
                ),
              ),
            ),
    );
  }
}
