import 'package:get/get.dart';

import '../controllers/all_review_controller.dart';

class AllReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllReviewController>(
      () => AllReviewController(),
    );
  }
}
