import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController phone, address;
  RxBool isHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    phone = TextEditingController();
    address = TextEditingController();
  }

  @override
  void onClose() {
    phone.dispose();
    address.dispose();
    super.onClose();
  }

  // TOASTIFY
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

  // GET ALL USER
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllUser() async* {
    yield* firestore.collection('user').snapshots();
  }

  // BUAT JASA SERVIS
  Future<void> buatJasaServis({required String uid, required String phone, required String address}) async {
    isLoading.value = true;
    if (phone != '' && address != '') {
      await firestore.collection('user').doc(uid).update({
        'phone': phone,
        'address': address,
        // 'role': 'ahli servis',
        'status': 'pending',
      });
      Get.back();
      isLoading.value = false;
      toast(title: 'Buat jasa berhasil', colors: Colors.green);
    } else {
      isLoading.value = false;
      toast(title: 'Phone number and address is required', colors: Colors.red);
    }
  }

  // GET PROFILE USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection('user').doc(uid).snapshots();
  }

  // GET JASA SERVIS
  Stream<QuerySnapshot<Map<String, dynamic>>> streamService() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection('service').where('userID', isEqualTo: uid).snapshots();
  }
}
