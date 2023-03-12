import 'package:get/get.dart';

import '../controllers/tambah_servis_controller.dart';

class TambahServisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahServisController>(
      () => TambahServisController(),
    );
  }
}
