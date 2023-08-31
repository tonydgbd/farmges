import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DrawerNavController extends GetxController {
  var activePage = 'home'.obs;

  void selectPage(String label) {
    activePage.value = label;
  }
}
