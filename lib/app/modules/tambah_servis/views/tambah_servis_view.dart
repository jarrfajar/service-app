import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/tambah_servis_controller.dart';

class TambahServisView extends GetView<TambahServisController> {
  const TambahServisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_rounded,
                            size: 24.0,
                          ),
                          Text("Kembali"),
                        ],
                      ),
                      onTap: () => Get.back(),
                    ),
                    const SizedBox(height: 15.0),
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
                          "Tambah jasa servis",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff172B4D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    // NAME
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
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            hintText: "Enter name",
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

                    // DESKRIPSI
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
                          controller: controller.desc,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            hintText: "Enter description",
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

                    // PRICE
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
                          controller: controller.price,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          inputFormatters: <TextInputFormatter>[
                            CurrencyTextInputFormatter(
                              locale: 'id',
                              decimalDigits: 0,
                              symbol: 'Rp ',
                              // customPattern: '.',
                            ),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            hintText: "Enter price",
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
                    const SizedBox(height: 20.0),

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
                        GetBuilder<TambahServisController>(
                          builder: (c) {
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

                    // BUTTON
                    const SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              // backgroundColor: Colors.teal,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                            onPressed: () {
                              print('Pressed');
                            },
                            child: const Text(
                              'Batal',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => SizedBox(
                            width: 140,
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: const Color(0xff6759FF),
                                shape:
                                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              ),
                              onPressed: () => controller.addjasa(
                                name: controller.name.text,
                                price: controller.price.text,
                                desc: controller.desc.text,
                              ),
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
                                      'Tambah',
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
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
