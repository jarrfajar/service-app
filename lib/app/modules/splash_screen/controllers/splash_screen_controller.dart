import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:service_app/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initTimer();
  }

  void initTimer() async {
    if (await checkinternet()) {
      Timer(const Duration(seconds: 2), () async {
        // Get.offAllNamed(Routes.LOGIN);
        final FirebaseAuth auth = FirebaseAuth.instance;

        var userVerif = auth.currentUser?.emailVerified == true;
        if (userVerif) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      });
    }
  }

  // CHECK INTERNET
  Future<bool> checkinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
