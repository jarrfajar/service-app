import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late TextEditingController name, email, password, passwordConfirm;
  RxBool isHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordConfirm = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
    super.onClose();
  }
}
