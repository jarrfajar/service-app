import 'package:get/get.dart';

import '../controllers/detail_service_controller.dart';

class DetailServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailServiceController>(
      () => DetailServiceController(),
    );
  }
}
