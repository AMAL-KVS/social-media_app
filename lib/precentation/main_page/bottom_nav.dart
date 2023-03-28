import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationBarWidgets extends StatelessWidget {
  const BottomNavigationBarWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) {
          return BottomNavigationBar(
              currentIndex: newIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.manage_accounts_rounded), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notification_add), label: '')
              ]);
        });
  }
}
