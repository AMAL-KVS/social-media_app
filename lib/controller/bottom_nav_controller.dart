import 'package:get/get.dart';

class bottomNav extends GetxController {
  RxInt selectedindex = 0.obs;

  bottomChange(int index) {
    selectedindex.value = index;
  }
}
