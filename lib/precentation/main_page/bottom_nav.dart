import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:social_media/core/constants/constands.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationBarWidgets extends StatelessWidget {
  const BottomNavigationBarWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius _borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    );

    ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    );
    SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
    EdgeInsets padding = const EdgeInsets.all(12);
    SnakeShape snakeShape = SnakeShape.circle;
    Color selectedColor = kblackcolor;
    Color unselectedColor = kbluecolor;

    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) {
          return SnakeNavigationBar.color(
              behaviour: snakeBarStyle,
              snakeShape: snakeShape,
              shape: bottomBarShape,
              snakeViewColor: selectedColor,
              selectedItemColor:
                  snakeShape == SnakeShape.indicator ? selectedColor : null,
              unselectedItemColor: unselectedColor,
              currentIndex: newIndex,
              //type: BottomNavigationBarType.fixed,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
                //BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '')
              ]);
        });
  }
}
