import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:service_app/app/data/CurrencyFormat.dart';
import 'package:service_app/app/routes/app_pages.dart';

import '../controllers/detail_product_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailProductView extends GetView<DetailProductController> {
  final uid = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'Detail Product',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamProduct(uid: uid),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
          }
          Map<String, dynamic> service = snap.data!.data()!;
          controller.hargaAwal.value = service['price'].substring(3, 9).replaceAll('.', '');
          controller.total.value = service['price'].substring(3, 9).replaceAll('.', '');

          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  Container(
                    height: 280,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                        image: NetworkImage(service['image'] ?? "https://ui-avatars.com/api/?name=fajar"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // NAMA PRODUCT
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['name'],
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          service['price'],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  // NAMA TOKO
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.SELLER_STORE, arguments: service['userID']),
                    // onTap: () => print(service['userID']),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service['namaPenjual'],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                // 'Lihat toko',
                                service['phone'],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  // DESKRIPSI
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              "Deskripsi",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff172B4D),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        ReadMoreText(
                          service['deskripsi'],
                          trimLines: 4,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),

                  // REVIEW
                  const SizedBox(
                    height: 10.0,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamReview(uid: uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
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
                                    Text(
                                      "Review (${snapshot.data!.docs.length})",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xff172B4D),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text("Tidak ada review"),
                              ],
                            ),
                          );
                        }

                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
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
                                  Text(
                                    "Review (${snapshot.data!.docs.length})",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xff172B4D),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length > 5 ? 5 : snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> review = snapshot.data!.docs[index].data();

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review['name'],
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: double.parse(review['rating']),
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemSize: 22,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      (review['rating'] == ''
                                          ? Container()
                                          : ReadMoreText(
                                              // service['deskripsi'],
                                              review['deskripsi'] != '' ? review['deskripsi'] : '-',
                                              trimLines: 4,
                                              colorClickableText: Colors.pink,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                              moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              style: const TextStyle(fontSize: 16.0),
                                            )),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  );
                                },
                              ),

                              // SEE ALL REVIEW
                              (snapshot.data!.docs.length > 5
                                  ? SizedBox(
                                      height: 40,
                                      width: double.maxFinite,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ), // <-- Radius
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xff6759FF),
                                          ),
                                        ),
                                        onPressed: () => Get.toNamed(Routes.ALL_REVIEW, arguments: uid),
                                        child: const Text(
                                          "See all review",
                                          style: TextStyle(color: Color(0xff6759FF)),
                                        ),
                                      ),
                                    )
                                  : Container()),

                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        );
                      }),

                  const SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color(0xff6759FF),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      Get.dialog(
                        barrierDismissible: false,
                        AlertDialog(
                          contentPadding: EdgeInsets.all(10),
                          // title: const Text("Buat jasa servis"),
                          content: Form(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Jumlah Unit",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xfff6759ff),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.remove_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () => controller.deccrement(),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Obx(
                                            () => Text(
                                              controller.count.value.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xfff6759ff),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () => controller.increment(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),

                                // DATE
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 70,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.date_range),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            const Text(
                                              "Date",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Obx(
                                              () => Text(
                                                (controller.date.value == ''
                                                    ? 'Select your date'
                                                    : DateFormat('dd MMMM yyyy')
                                                        .format(DateTime.parse(controller.date.value))),
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    DatePicker.showDatePicker(
                                      context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                      onConfirm: (date) {
                                        controller.date.value = date.toIso8601String();
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.id,
                                    );
                                  },
                                ),
                                const SizedBox(height: 20.0),

                                // TIME PICKER
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 70,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Time",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Obx(
                                              () => Text(
                                                (controller.time.value == ''
                                                    ? 'Select your time'
                                                    : DateFormat('HH:mm')
                                                        .format(DateTime.parse(controller.time.value))),
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    DatePicker.showTime12hPicker(
                                      context,
                                      showTitleActions: true,
                                      onConfirm: (date) {
                                        controller.time.value = date.toString();
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.id,
                                    );
                                  },
                                ),

                                const SizedBox(height: 20.0),

                                // MEREK UNIT
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
                                      controller: controller.deskripsi,
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(color: Colors.grey[600]),
                                        hintText: "Deskripsi atau merek barang",
                                        fillColor: Colors.grey[200],
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
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Masukkan gambar (optional)"),
                                    GetBuilder<DetailProductController>(
                                      builder: (c) {
                                        if (c.imagePicker != null) {
                                          return Container(
                                            height: 100,
                                            width: 100,
                                            child: Image.file(
                                              File(c.imagePicker!.path),
                                              // File(c.imagePicker!.path),
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        } else {
                                          return Text("Masukkan gambar");
                                        }
                                      },
                                    ),
                                    GetBuilder<DetailProductController>(
                                      builder: (c) {
                                        if (c.imagePicker != null) {
                                          return TextButton(
                                            onPressed: () => controller.deleteImage(),
                                            child: Text("hapus gambar"),
                                          );
                                        } else {
                                          return TextButton(
                                            onPressed: () => controller.pickImage(),
                                            child: Text("pilih gambar"),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),

                                // ADDRESS
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
                                        hintStyle: TextStyle(color: Colors.grey[600]),
                                        hintText: "Masukkan alamat",
                                        fillColor: Colors.grey[200],
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
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),

                                // PHONE
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
                                        hintStyle: TextStyle(color: Colors.grey[600]),
                                        hintText: "Masukkan nomor HP",
                                        fillColor: Colors.grey[200],
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
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Total:",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Obx(
                                      () => Text(
                                        // controller.total.value,
                                        CurrencyFormat.convertToIdr(int.parse(controller.total.value), 0),
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // <-- Radius
                                ),
                                side: const BorderSide(
                                  color: Color(0xff6759FF),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                                // isLoading.value = false;
                              },
                              child: const Text(
                                "Batal",
                                style: TextStyle(color: Color(0xff6759FF)),
                              ),
                            ),
                            Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff6759FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ), // <-- Radius
                                  ),
                                ),
                                onPressed: () {
                                  controller.booking(
                                    serviceID: uid,
                                    penjualID: service['userID'],
                                    image: service['image'],
                                    name: service['name'],
                                    jumlah: controller.count.value.toString(),
                                    tanggal: controller.date.value,
                                    jam: controller.time.value,
                                    deskripsi: controller.deskripsi.text,
                                    total: controller.total.value,
                                    address: controller.address.text,
                                    uidAhliServis: service['userID'],
                                    phone: controller.phone.text,
                                  );
                                  // print(service['name']);
                                },
                                child: (controller.isLoading.isTrue
                                    ? const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text("Pesan")),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Pesan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
