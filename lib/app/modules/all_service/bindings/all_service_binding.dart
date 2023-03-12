import 'package:get/get.dart';

import '../controllers/all_service_controller.dart';

class AllServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllServiceController>(
      () => AllServiceController(),
    );
  }
}
