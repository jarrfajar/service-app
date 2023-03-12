import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TambahServisController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  late TextEditingController name, price, image, desc;

  // IMAGE PICKER
  final ImagePicker picker = ImagePicker();
  XFile? imagePicker;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    price = TextEditingController();
    desc = TextEditingController();
    image = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    price.dispose();
    desc.dispose();
    image.dispose();
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

  void pickImage() async {
    imagePicker = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> addjasa({required String name, required String price, required String desc}) async {
    isLoading.value = true;

    String uid = await auth.currentUser!.uid;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    // GET PHONE NUMBER
    var collection = firestore.collection('user');
    var docSnapshot = await collection.doc(uid).get();
    Map<String, dynamic>? data = docSnapshot.data();
    String phone = data?['phone'];
    String namaPenjual = data?['name'];

    if (name != '' && price != '' && desc != '' && imagePicker != null) {
      try {
        if (imagePicker != null) {
          File file = File(imagePicker!.path);
          String fileName = imagePicker!.name.split('.').first;
          String ext = imagePicker!.name.split('.').last;

          await storage.ref('$uid/$fileName.$ext').putFile(file);
          String uri = await storage.ref('$uid/$fileName.$ext').getDownloadURL();

          await firestore.collection('service').doc().set({
            'userID': uid,
            'name': name,
            'price': price,
            'image': uri,
            'deskripsi': desc,
            'phone': phone,
            'status': 'tersedia',
            'namaPenjual': namaPenjual,
            'createAt': dateFormat.format(DateTime.now()),
          });

          // await firestore.collection('service').doc().collection('review').doc().set({})

          toast(title: 'Berhasil', colors: Colors.green);
          Get.back();
          isLoading.value = false;
        }
      } catch (e) {
        toast(title: 'Error', colors: Colors.red);
        isLoading.value = false;
        print(['error', e]);
      }
    } else {
      toast(title: 'Name, price and image is required', colors: Colors.red);
      isLoading.value = false;
    }
  }
}
