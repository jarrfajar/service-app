import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:service_app/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // GET NAME USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection('user').doc(uid).snapshots();
  }

  void changePage(int i) {
    pageIndex.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.STORE);
        break;
      case 2:
        Get.offAllNamed(Routes.BOOKING);
        break;
      case 3:
        Get.offAllNamed(Routes.NOTIFICATION);
        break;
      case 4:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  void changePageRoleUser(int i) {
    pageIndex.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.STORE);
        break;
      case 2:
        Get.offAllNamed(Routes.BOOKING);
        break;
      case 3:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }
}
