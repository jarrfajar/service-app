import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DetailProductController extends GetxController {
  RxBool isLoading = false.obs;

  final count = 1.obs;
  final date = "".obs;
  final time = "".obs;
  RxString hargaAwal = ''.obs;
  RxString total = ''.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController name, jumlah, tanggal, jam, deskripsi, address, phone;

// IMAGE PICKER
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  XFile? imagePicker;

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

  // STREAM PRODUCT
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProduct({required String uid}) async* {
    yield* firestore.collection('service').doc(uid).snapshots();
  }

  // STREAM REVIEW
  Stream<QuerySnapshot<Map<String, dynamic>>> streamReview({required String uid}) async* {
    yield* firestore.collection('service').doc(uid).collection('review').where('rating', isNotEqualTo: '0').snapshots();
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

  // PICK IMAGE
  void pickImage() async {
    imagePicker = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void deleteImage() {
    imagePicker = null;
    update();
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
      if (imagePicker != null) {
        File file = File(imagePicker!.path);
        String ext = imagePicker!.name.split('.').last;
        String date = DateTime.now().toIso8601String();

        await storage.ref('service/$date.$ext').putFile(file);
        String uri = await storage.ref('service/$date.$ext').getDownloadURL();

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
          'imageService': uri,
        });

        isLoading.value = false;
        Get.back();
        Get.back();
        toast(title: 'Berhasil', colors: Colors.green);
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
        Get.back();
        toast(title: 'Berhasil', colors: Colors.green);
      }
    }
  }
}
