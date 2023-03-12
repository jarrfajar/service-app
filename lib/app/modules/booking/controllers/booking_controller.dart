import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  RxString rating = '0'.obs;

  late TextEditingController ulasan;
  RxBool isHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    ulasan = TextEditingController();
  }

  @override
  void onClose() {
    ulasan.dispose();
    super.onClose();
  }

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

  // GET NAME USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection('user').doc(uid).snapshots();
  }

  // GET BOOKING USER
  Stream<QuerySnapshot<Map<String, dynamic>>> streamBooking() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore
        .collection('booking')
        .where('userID', isEqualTo: uid)
        .where('service', isEqualTo: 'yes')
        .snapshots();
  }

  // GET HISTORY BOOKING USER
  Stream<QuerySnapshot<Map<String, dynamic>>> streamHistoryBooking() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore
        .collection('booking')
        .where('userID', isEqualTo: uid)
        .where('service', isEqualTo: 'selesai')
        // .orderBy('date', descending: true)
        .snapshots();
  }

  // KONFIRMASI PESANAN
  Future<void> konfirmasiPesanan({
    required String bookingID,
    required String name,
    required String date,
    required String time,
    required String address,
    required String price,
    required String deskripsi,
    required String image,
    required String jumlah,
    required String penjualID,
    required String userID,
    required String serviceID,
    required String ulasan,
    required String rating,
  }) async {
    isLoading.value = true;
    // GET NAME USER
    var collection = firestore.collection('user');
    var docSnapshot = await collection.doc(userID).get();
    Map<String, dynamic>? data = docSnapshot.data();
    String nameUser = data?['name'];

    try {
      await firestore.collection('booking').doc(bookingID).update({
        'service': 'selesai',
        // 'name': nameUser,
        'name': name,
        'rating': rating,
        'ulasan': ulasan,
        'date': DateTime.now().toIso8601String(),
      });

      // RATING
      await firestore.collection('service').doc(serviceID).collection('review').doc().set({
        'name': nameUser,
        'rating': rating,
        'deskripsi': ulasan,
        'date': DateTime.now().toIso8601String(),
      });
      isLoading.value = false;
      Get.back();
      toast(title: 'Berhasil', colors: Colors.green);
    } catch (e) {
      isLoading.value = false;
      toast(title: 'Kesalahan server', colors: Colors.red);
    }
  }
}
