import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  // TOATS
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

  // GET USER
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUser() async* {
    yield* firestore.collection('user').snapshots();
  }

  // KONFIRMASI USER KE AHLI SERVIS
  Future<void> konfirmasiServis({required String uid}) async {
    try {
      isLoading.value = true;

      await firestore.collection('user').doc(uid).update({
        'status': '',
        'role': 'ahli servis',
      });
      Get.back();
      toast(title: 'Berhasil', colors: Colors.green);
    } catch (e) {
      toast(title: 'Kesalahan server', colors: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
