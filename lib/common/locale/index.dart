import 'package:get/get.dart';
import 'package:kaino/common/locale/zh_CN.dart';
import 'package:kaino/common/locale/en_US.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zh_CN,
        'en_US': en_US,
      };
}
