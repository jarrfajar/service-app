import 'package:get/get.dart';

import '../controllers/servis_controller.dart';

class ServisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServisController>(
      () => ServisController(),
    );
  }
}
