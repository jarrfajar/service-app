import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AllServiceController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  RxString searchObs = ''.obs;
  String search = '';

  late TextEditingController name, price, desc;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    price = TextEditingController();
    desc = TextEditingController();
    // image = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    price.dispose();
    desc.dispose();
    // image.dispose();
    super.onClose();
  }

  // TOAST
  void toast({required String title, required Color colors, int second = 1}) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colors,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // UPDATE SERVICE
  Future<void> updateService({required String uid, required String name, required String price}) async {
    isLoading.value = true;
    if (name == '' || price == '') {
      isLoading.value = false;
      toast(title: 'Name and price is required', colors: Colors.red);
    } else {
      await firestore.collection('service').doc(uid).update({
        'name': name,
        'price': price,
      });
      isLoading.value = false;
      Get.back();
      toast(title: 'Update service success', colors: Colors.green);
    }
    isLoading.value = false;
  }

  Future<void> deleteService({required String uid}) async {
    try {
      isLoading.value = true;
      await firestore.collection('service').doc(uid).delete();
      Get.back();
      toast(title: 'Delete service success', colors: Colors.green);
      isLoading.value = false;
    } catch (e) {
      Get.back();
      toast(title: 'Delete service gagal', colors: Colors.red);
      isLoading.value = false;
    }
  }

  // GET SERVICE
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllService() async* {
    yield* firestore.collection('service').orderBy('createAt', descending: true).snapshots();
  }
}
