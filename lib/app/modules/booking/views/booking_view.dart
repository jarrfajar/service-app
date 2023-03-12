import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:service_app/app/controllers/page_index_controller.dart';
import 'package:service_app/app/data/CurrencyFormat.dart';

import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  PageIndexController pageIndexController = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> data = snap.data!.data()!;

          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(
                              alignment: Alignment.centerRight,
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
                                      "Booking",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xff172B4D),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 40.0,
                            child: Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.current.value = 1;
                                    },
                                    child: Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        color: (controller.current.value == 1 ? const Color(0xfff0eeff) : Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Upcoming",
                                          style: TextStyle(
                                            // color: Color(0xff6759FF), 0xff172B4D
                                            color: (controller.current.value == 1
                                                ? const Color(0xff6759FF)
                                                : const Color(0xff172B4D)),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.current.value = 2;
                                    },
                                    child: Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        color: (controller.current.value == 1 ? Colors.white : const Color(0xfff0eeff)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "History",
                                          style: TextStyle(
                                            // color: Color(0xff6759FF), 0xff172B4D
                                            color: (controller.current.value == 1
                                                ? const Color(0xff172B4D)
                                                : const Color(0xff6759FF)),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BODY
                  Obx(
                    () => Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (controller.current.value == 1
                                ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                    stream: controller.streamBooking(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                                        return const Center(child: Text("Tidak ada pesanan sa"));
                                      }
                                      // if (snapshot.data == null) {
                                      //   return const Center(child: Text("Tidak ada pesanan sa"));
                                      // }

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> booking = snapshot.data!.docs[index].data();

                                          // if (snapshot.data!.docs.isNotEmpty) {
                                          //   return Container(
                                          //     child: Text(booking['address']),
                                          //   );
                                          // }
                                          print(snapshot.data!.docs.length);

                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  ClipOval(
                                                    child: SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: Image.network(
                                                        booking['image'] ??
                                                            "https://ui-avatars.com/api/?name=${booking['name']}",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          booking['name'],
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.0,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 3,
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          booking['phone'],
                                                          style: const TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // const Divider(thickness: 1),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Status",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  Chip(
                                                    label: Text(booking['status']),
                                                    backgroundColor: (booking['status'] == 'pending'
                                                        ? const Color(0xffffd88d)
                                                        : booking['status'] == 'confirmed'
                                                            ? const Color(0xfffb9b9b)
                                                            : const Color(0xfffb5ebcd)),
                                                  ),
                                                ],
                                              ),
                                              Row(
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
                                                      Text(
                                                        DateFormat('dd MMMM yyyy')
                                                            .format(DateTime.parse(booking['tanggal'])),
                                                        style: const TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    // ignore: prefer_const_literals_to_create_immutables
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
                                                      Text(
                                                        DateFormat('HH:mm').format(DateTime.parse(booking['jam'])),
                                                        style: const TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons.home_outlined),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          "Address",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text(
                                                          booking['address'],
                                                          style: const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 3,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons.description_outlined),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          "Deskripsi",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text(
                                                          booking['deskripsi'],
                                                          style: const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 3,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              // IMAGE DESCRIPTION
                                              Row(
                                                children: [
                                                  const Icon(Icons.image),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          "Image",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        booking['imageService'] != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  Get.dialog(AlertDialog(
                                                                    content: SizedBox(
                                                                      // width: 60,
                                                                      // height: 60,
                                                                      child: Image.network(
                                                                        booking['imageService'],
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ));
                                                                },
                                                                child: const Text(
                                                                  "Lihat foto",
                                                                  style: TextStyle(
                                                                    fontSize: 18.0,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.blueAccent,
                                                                  ),
                                                                ),
                                                              )
                                                            : Text("no foto"),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons.price_check),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      const Text(
                                                        "Price",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        // booking['total'],
                                                        CurrencyFormat.convertToIdr(int.parse(booking['total']), 0),
                                                        style: const TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),

                                              (booking['status'] == 'Confirmed'
                                                  ? const SizedBox(
                                                      height: 20.0,
                                                    )
                                                  : Container()),

                                              (booking['status'] == 'Confirmed'
                                                  ? SizedBox(
                                                      width: double.maxFinite,
                                                      height: 50,
                                                      child: OutlinedButton(
                                                        style: OutlinedButton.styleFrom(
                                                          primary: Colors.white,
                                                          backgroundColor: const Color(0xff6759FF),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                                        ),
                                                        onPressed: () {
                                                          Get.dialog(
                                                            AlertDialog(
                                                              content: Form(
                                                                child: ListView(
                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                  shrinkWrap: true,
                                                                  children: [
                                                                    const Text(
                                                                      'Dengan menekan setuju berarti pesanan telah selesai dilakukan!',
                                                                    ),
                                                                    const SizedBox(height: 10),
                                                                    RatingBar.builder(
                                                                      // initialRating: 3,
                                                                      minRating: 1,
                                                                      itemSize: 30,
                                                                      direction: Axis.horizontal,
                                                                      allowHalfRating: false,
                                                                      itemCount: 5,
                                                                      itemPadding:
                                                                          const EdgeInsets.symmetric(horizontal: 4.0),
                                                                      itemBuilder: (context, _) => const Icon(
                                                                        Icons.star,
                                                                        color: Colors.amber,
                                                                      ),
                                                                      onRatingUpdate: (rating) {
                                                                        controller.rating.value =
                                                                            rating.toString().replaceAll('.0', '');
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 10.0,
                                                                    ),

                                                                    // ULASAN
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
                                                                          controller: controller.ulasan,
                                                                          maxLines: null,
                                                                          keyboardType: TextInputType.multiline,
                                                                          decoration: InputDecoration(
                                                                            filled: true,
                                                                            hintStyle:
                                                                                TextStyle(color: Colors.grey[600]),
                                                                            hintText: "Masukkan ulasan",
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
                                                                              borderSide:
                                                                                  BorderSide(color: Colors.transparent),
                                                                            ),
                                                                            contentPadding: const EdgeInsets.symmetric(
                                                                                vertical: 22, horizontal: 15),
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
                                                                    style: TextStyle(color: const Color(0xff6759FF)),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    primary: const Color(0xff6759FF),
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(
                                                                        8,
                                                                      ), // <-- Radius
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    controller.konfirmasiPesanan(
                                                                      serviceID: booking['serviceID'],
                                                                      rating: controller.rating.value,
                                                                      ulasan: controller.ulasan.text,
                                                                      bookingID: snapshot.data!.docs[index].id,
                                                                      name: booking['name'],
                                                                      date: booking['tanggal'],
                                                                      time: booking['jam'],
                                                                      address: booking['address'],
                                                                      price: booking['total'],
                                                                      deskripsi: booking['deskripsi'],
                                                                      image: booking['image'],
                                                                      jumlah: booking['jumlah'],
                                                                      penjualID: booking['penjualID'],
                                                                      userID: booking['userID'],
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
                                                                          'Setuju',
                                                                          style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16.0,
                                                                          ),
                                                                        )),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Konfirmasi pesanan',
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container()),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                children: List.generate(
                                                  150 ~/ 2,
                                                  (index) => Expanded(
                                                    child: Container(
                                                      color: index % 2 == 0
                                                          ? Colors.transparent
                                                          : const Color.fromARGB(255, 209, 209, 209),
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )

                                // HISTORY
                                : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                    stream: controller.streamHistoryBooking(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                                        return const Center(child: Text("Tidak ada pesanan"));
                                      }
                                      // Map<String, dynamic> booking = snapshot.data!.data()!;

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> booking = snapshot.data!.docs[index].data();

                                          // if (booking['service'] == 'selesai') {
                                          //   return const Center(
                                          //     child: Text("Tidak ada pesanan sasa"),
                                          //   );
                                          // }
                                          if (booking['service'] == 'selesai') {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    ClipOval(
                                                      child: SizedBox(
                                                        width: 60,
                                                        height: 60,
                                                        child: Image.network(
                                                          booking['image'] ??
                                                              "https://ui-avatars.com/api/?name=${booking['name']}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            booking['name'],
                                                            // booking['name'],
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20.0,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 3,
                                                          ),
                                                          const SizedBox(height: 5),
                                                          Text(
                                                            booking['phone'],
                                                            style: const TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // const Divider(thickness: 1),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Status",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    Chip(
                                                      label: Text(booking['status']),
                                                      backgroundColor: (booking['status'] == 'Confirmed'
                                                          ? const Color(0xfffb5ebcd)
                                                          : const Color(0xfffb9b9b)),
                                                    ),
                                                  ],
                                                ),
                                                Row(
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
                                                        Text(
                                                          DateFormat('dd MMMM yyyy')
                                                              .format(DateTime.parse(booking['tanggal'])),
                                                          style: const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.access_time),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      // ignore: prefer_const_literals_to_create_immutables
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
                                                        Text(
                                                          DateFormat('HH:mm').format(DateTime.parse(booking['jam'])),
                                                          style: const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.home_outlined),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          const Text(
                                                            "Address",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            booking['address'],
                                                            style: const TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 3,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.description_outlined),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          const Text(
                                                            "Deskripsi",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            booking['deskripsi'],
                                                            style: const TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 3,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),

                                                // IMAGE DESCRIPTION
                                                Row(
                                                  children: [
                                                    const Icon(Icons.image),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          const Text(
                                                            "Image",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          booking['imageService'] != null
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    Get.dialog(AlertDialog(
                                                                      content: SizedBox(
                                                                        // width: 60,
                                                                        // height: 60,
                                                                        child: Image.network(
                                                                          booking['imageService'],
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                    ));
                                                                  },
                                                                  child: const Text(
                                                                    "Lihat foto",
                                                                    style: TextStyle(
                                                                      fontSize: 18.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.blueAccent,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Text("no foto"),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                //
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.price_check),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          "Price",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text(
                                                          // booking['total'],
                                                          CurrencyFormat.convertToIdr(int.parse(booking['total']), 0),
                                                          style: const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.star_border_rounded),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          "Rating",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        RatingBar.builder(
                                                          ignoreGestures: true,
                                                          initialRating: double.parse(booking['rating']),
                                                          direction: Axis.horizontal,
                                                          itemCount: 5,
                                                          itemSize: 22,
                                                          itemBuilder: (context, _) => const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate: (rating) {},
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.library_add_check_outlined),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          const Text(
                                                            "Ulasan",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          SizedBox(
                                                            child: Text(
                                                              (booking['ulasan'] != '' ? booking['ulasan'] : '-'),
                                                              style: const TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 3,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  children: List.generate(
                                                    150 ~/ 2,
                                                    (index) => Expanded(
                                                      child: Container(
                                                        color: index % 2 == 0
                                                            ? Colors.transparent
                                                            : const Color.fromARGB(255, 209, 209, 209),
                                                        height: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                              ],
                                            );
                                          }

                                          return Container();
                                        },
                                      );
                                    },
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM NAVIGATION BAR
            bottomNavigationBar: (data['role'] == 'ahli servis' || data['role'] == 'admin'
                ? SalomonBottomBar(
                    currentIndex: pageIndexController.pageIndex.value,
                    onTap: (i) => pageIndexController.changePage(i),
                    items: [
                      /// Home
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.home_outlined),
                        title: const Text("Home"),
                        selectedColor: const Color(0xff6759FF),
                      ),

                      SalomonBottomBarItem(
                        icon: const Icon(Icons.store),
                        title: const Text("Store"),
                        selectedColor: const Color(0xff6759FF),
                      ),

                      /// Likes
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.article_outlined),
                        title: const Text("Booking"),
                        selectedColor: const Color(0xff6759FF),
                      ),

                      /// Search
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.notifications_none),
                        title: const Text("Notification"),
                        selectedColor: const Color(0xff6759FF),
                      ),

                      /// Profile
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.person_outline),
                        title: const Text("Profile"),
                        selectedColor: const Color(0xff6759FF),
                      ),
                    ],
                  )
                : SalomonBottomBar(
                    currentIndex: pageIndexController.pageIndex.value,
                    onTap: (i) => pageIndexController.changePageRoleUser(i),
                    items: [
                      /// Home
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.home_outlined),
                        title: const Text("Home"),
                        selectedColor: const Color(0xff6759FF),
                      ),

                      SalomonBottomBarItem(
                        icon: const Icon(Icons.store),
                        title: const Text("Store"),
                        selectedColor: const Color(0xff6759FF),
                      ),

                      /// Likes
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.article_outlined),
                        title: const Text("Booking"),
                        selectedColor: const Color(0xff6759FF),
                      ),

                      /// Profile
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.person_outline),
                        title: const Text("Profile"),
                        selectedColor: const Color(0xff6759FF),
                      ),
                    ],
                  )),
          );
        });
  }
}
