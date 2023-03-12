import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // IMAGE PICKER
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  XFile? imagePicker;

  late TextEditingController name, email, phone, address;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
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

  // UPDATE PROFILE
  Future<void> updateProfile({
    required String uid,
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    isLoading.value = true;
    if (name == '' && phone == '' && address == '') {
      isLoading.value = false;
      toast(title: 'name, phone and addres is required', colors: Colors.red, second: 5);
    } else {
      try {
        if (imagePicker != null) {
          File file = File(imagePicker!.path);
          String ext = imagePicker!.name.split('.').last;

          await storage.ref('$uid/profile.$ext').putFile(file);
          String uri = await storage.ref('$uid/profile.$ext').getDownloadURL();

          await firestore.collection('user').doc(uid).update({
            'name': name,
            'phone': phone,
            'address': address,
            'image': uri,
          });

          Get.back();
          isLoading.value = false;
          toast(title: 'Berhasil', colors: Colors.green);
        }
      } catch (e) {
        toast(title: 'Error', colors: Colors.red);
        isLoading.value = false;
        print(['error', e]);
      }

      toast(title: 'Update profile success', colors: Colors.green);
    }
  }
}
