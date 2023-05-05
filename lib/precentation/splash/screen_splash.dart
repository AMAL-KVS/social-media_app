import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:social_media/precentation/splash/state_checking_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  Future gotohome() async {
    await Future.delayed(const Duration(seconds: 2));

    Get.offAll(() => const StateCheckingWidget(),
        transition: Transition.circularReveal,
        duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      gotohome();
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    splashImage,
                    width: 250,
                    height: 250,
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'AmJoZ',
                style: TextStyle(fontFamily: 'RaleWay', fontSize: 15),
              ),
            ],
          ),
          kheight20
        ],
      ),
    );
  }
}

class Ipanint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
