import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailServiceController extends GetxController {
  RxBool isLoading = false.obs;

  final count = 1.obs;
  final date = "".obs;
  final time = "".obs;
  RxString hargaAwal = ''.obs;
  RxString total = ''.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController name, jumlah, tanggal, jam, deskripsi, address, phone;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    jumlah = TextEditingController();
    tanggal = TextEditingController();
    jam = TextEditingController();
    deskripsi = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    jumlah.dispose();
    tanggal.dispose();
    jam.dispose();
    deskripsi.dispose();
    address.dispose();
    phone.dispose();
    super.onClose();
  }

  void increment() async {
    count.value++;
    int getTotal = int.parse(total.value) + int.parse(hargaAwal.value);
    total.value = getTotal.toString();
  }

  void deccrement() {
    if (count.value != 1) {
      count.value--;

      int getTotal = int.parse(total.value) - int.parse(hargaAwal.value);
      total.value = getTotal.toString();
    }
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

  // PESAN/BOOKING
  Future<void> booking({
    required String name,
    required String jumlah,
    required String tanggal,
    required String jam,
    required String deskripsi,
    required String total,
    required String address,
    required String uidAhliServis,
    required String image,
    required String serviceID,
    required String penjualID,
    required String phone,
  }) async {
    isLoading.value = true;
    if (tanggal == '' || jam == '' || deskripsi == '' || address == '' || phone == '') {
      isLoading.value = false;
      toast(title: 'Date, time, alamat, phone and deskripsi is required', colors: Colors.red, second: 5);
    } else {
      // GET UID USER
      String uid = auth.currentUser!.uid;
      await firestore.collection('booking').doc().set({
        'name': name,
        'jumlah': jumlah,
        'tanggal': tanggal,
        'jam': jam,
        'deskripsi': deskripsi,
        'total': total,
        'address': address,
        'status': 'pending',
        'service': 'yes',
        'image': image,
        'userID': uid,
        'penjualID': penjualID,
        'serviceID': serviceID,
        'phone': phone,
      });

      isLoading.value = false;
      Get.back();
      toast(title: 'Berhasil', colors: Colors.green);
    }
  }
}
