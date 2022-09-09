import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomController extends GetxController {
  late PageController pageController;
  void addPage(PageController pageController) {
    this.pageController = pageController;
  }

  pageChange() {
    pageController.jumpToPage(0);
  }
}
