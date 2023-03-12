import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  RxBool isLoadingConfirm = false.obs;
  RxBool isLoadingReject = false.obs;

  List<String> items = [
    "Home",
    "Explore",
    "Search",
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.explore,
    Icons.search,
  ];
  RxInt current = 1.obs;

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

  // GET BOOKING USER
  Stream<QuerySnapshot<Map<String, dynamic>>> streamBooking() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore
        .collection('booking')
        .where('penjualID', isEqualTo: uid)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  // GET HISTOY PESANAN
  Stream<QuerySnapshot<Map<String, dynamic>>> streamHistoryService() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore
        .collection('booking')
        .where('penjualID', isEqualTo: uid)
        .where('service', isEqualTo: 'selesai')
        .snapshots();
  }

  // JASA SERVIS KONFIRMASI PESANAN
  Future<void> confirmBooking({required String id}) async {
    try {
      isLoadingConfirm.value = true;
      String uid = await auth.currentUser!.uid;
      await firestore.collection('booking').doc(id).update({
        'status': 'Confirmed',
        'service': 'yes',
        // 'service': 'selesai',
      });
      toast(title: 'Konfirmasi persanan berhasil', colors: Colors.green);
      Get.back();
      isLoadingConfirm.value = false;
    } catch (e) {
      toast(title: 'Konfirmasi persanan gagal', colors: Colors.red);
      isLoadingConfirm.value = false;
    }
  }

  // JASA SERVIS TOLAK PESANAN
  Future<void> rejectBooking({required String id}) async {
    try {
      isLoadingReject.value = true;
      String uid = await auth.currentUser!.uid;
      await firestore.collection('booking').doc(id).update({
        'status': 'Reject',
        'service': 'selesai',
      });
      toast(title: 'Reject persanan berhasil', colors: Colors.green);
      Get.back();
      isLoadingReject.value = false;
    } catch (e) {
      toast(title: 'Reject persanan gagal', colors: Colors.red);
      isLoadingReject.value = false;
    }
  }

  // GET ROLE USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection('user').doc(uid).snapshots();
  }
}
