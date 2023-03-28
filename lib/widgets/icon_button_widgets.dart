import 'package:flutter/material.dart';

class IconButtonWidgets extends StatelessWidget {
  final Icon icon;
  final Function()? ontap1;
  const IconButtonWidgets({required this.icon, required this.ontap1, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromARGB(255, 212, 210, 207)),
      child: IconButton(
        onPressed: ontap1,
        icon: icon,
      ),
    );
  }
}
