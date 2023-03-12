import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  final profile = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.name.text = profile['name'];
    controller.phone.text = profile['phone'];
    controller.address.text = profile['address'];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back_rounded,
                              size: 24.0,
                            ),
                            Text("Kembali"),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xffCABDFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Text(
                          "Update profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff172B4D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),

                    // PROFILE USER
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // NAME
                          const Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Stack(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              TextFormField(
                                controller: controller.name,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  hintText: profile['name'],
                                  fillColor: const Color(0xfffF5F5F5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                                ),
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),

                          (profile['role'] == 'user'
                              ? const SizedBox(height: 1.0)
                              : // PHONE NUMBER
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: controller.phone,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            filled: true,
                                            hintStyle: TextStyle(color: Colors.grey[500]),
                                            // hintText: (profile['phone'] == null ? "Not Set" : "${profile['phone']}"),
                                            hintText: profile['phone'],
                                            fillColor: const Color(0xfffF5F5F5),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12.0),
                                              ),
                                              borderSide: BorderSide(color: Colors.transparent),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),

                                    // ADDRESS
                                    const Text(
                                      "Address",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: controller.address,
                                          decoration: InputDecoration(
                                            filled: true,
                                            hintStyle: TextStyle(color: Colors.grey[500]),
                                            // hintText: (profile['address'] == null ? "Not Set" : "${profile['address']}"),
                                            hintText: profile['address'],
                                            fillColor: const Color(0xfffF5F5F5),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12.0),
                                              ),
                                              borderSide: BorderSide(color: Colors.transparent),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),

                                    // IMAGE
                                    const Text(
                                      "Image",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GetBuilder<EditProfileController>(
                                          builder: (c) {
                                            // if (profile['image'] != '') {
                                            //   return CircleAvatar(
                                            //     radius: 50.0,
                                            //     backgroundImage: NetworkImage(profile['image']),
                                            //     backgroundColor: Colors.transparent,
                                            //   );
                                            // }
                                            if (c.imagePicker != null) {
                                              return SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.file(
                                                  File(c.imagePicker!.path),
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            } else {
                                              if (profile['image'] != '') {
                                                return CircleAvatar(
                                                  radius: 50.0,
                                                  backgroundImage: NetworkImage(profile['image']),
                                                  backgroundColor: Colors.transparent,
                                                );
                                              }
                                              return const Text(
                                                "Choose Image",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        GestureDetector(
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Choose",
                                                style: TextStyle(
                                                  color: Color(0xff6759FF),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 5.0),
                                              Icon(
                                                Icons.image_search_rounded,
                                                color: Color(0xff6759FF),
                                              )
                                            ],
                                          ),
                                          onTap: () {
                                            controller.pickImage();
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                )),

                          const SizedBox(height: 40.0),

                          // BUTTON SAVE
                          Obx(
                            () => SizedBox(
                              width: double.maxFinite,
                              height: 50,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: const Color(0xff6759FF),
                                  shape:
                                      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                ),
                                onPressed: () {
                                  controller.updateProfile(
                                    uid: profile['uid'],
                                    name: controller.name.text,
                                    email: controller.email.text,
                                    phone: controller.phone.text,
                                    address: controller.address.text,
                                  );
                                },
                                child: (controller.isLoading.isTrue
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
