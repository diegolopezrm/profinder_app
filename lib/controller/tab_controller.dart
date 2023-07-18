//create tab controller to call whether to show the tab bar or not

/* int _page = 0; */


import 'package:get/get.dart';

class TabControllerApp extends GetxController {
  int _page = 0;

  int get page => _page;

  void setPage(int index) {
    _page = index;
    update();
  }
}

