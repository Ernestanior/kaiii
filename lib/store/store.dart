import 'package:get/get.dart';

class Controller extends GetxController {
  static Controller get c => Get.find();
  var token = ''.obs;
  var user = RxMap<String, dynamic>({});
  var language = 'en_US'.obs;
}
