import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:service_app/app/controllers/page_index_controller.dart';
import 'package:service_app/app/data/CurrencyFormat.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  PageIndexController pageIndexController = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: controller.streamUser(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        Map<String, dynamic> user = snap.data!.data()!;

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
                                    "Pesanan Servis",
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
                                        "Confirmation",
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

                Obx(
                  () => (controller.current.value == 1
                      ?
                      // BODY
                      // KONFIRMASI PESANAN
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.streamBooking(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Text("Tidak ada notif"),
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> booking = snapshot.data!.docs[index].data();

                                // if (booking['service'] == 'no') {
                                if (booking['status'] == 'Confirmed') {
                                  return Container();
                                }

                                return Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Column(
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
                                                        'Jumlah: ${booking['jumlah']}',
                                                        // booking['name'],
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        CurrencyFormat.convertToIdr(int.parse(booking['total']), 0),
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
                                                  // backgroundColor: const Color(0xffffd88d),
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
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 3,
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
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 3,
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
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 15.0),

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
                                              height: 20.0,
                                            ),

                                            // BUTTON
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: 140,
                                                  height: 50,
                                                  child: OutlinedButton(
                                                    style: OutlinedButton.styleFrom(
                                                      primary: Colors.white,
                                                      backgroundColor: const Color(0xfffb9b9b),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                                    ),
                                                    // onPressed: () =>
                                                    //     controller.rejectBooking(id: snapshot.data!.docs[index].id),
                                                    onPressed: () {
                                                      Get.dialog(
                                                        AlertDialog(
                                                          content: const Form(
                                                            child: Text('Tolak Pesanan?'),
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
                                                                  controller.rejectBooking(
                                                                      id: snapshot.data!.docs[index].id);
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
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      'Reject',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 140,
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
                                                          content: const Form(
                                                            child: Text('Konfirmasi Pesanan?'),
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
                                                                  controller.confirmBooking(
                                                                    id: snapshot.data!.docs[index].id,
                                                                  );
                                                                },
                                                                child: (controller.isLoadingConfirm.isTrue
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
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      'Confirmed',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      :
                      // BODY
                      // HISTORY
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.streamHistoryService(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Text("Tidak ada notif"),
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> booking = snapshot.data!.docs[index].data();

                                // if (booking['service'] == 'no') {
                                // if (booking['status'] == 'Confirmed') {
                                //   return Container();
                                // }

                                return Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Column(
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
                                                        'Jumlah: ${booking['jumlah']}',
                                                        // booking['name'],
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        CurrencyFormat.convertToIdr(int.parse(booking['total']), 0),
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
                                                  backgroundColor: (booking['status'] == 'Reject'
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
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),

                                            const SizedBox(height: 15.0),

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
                                                          booking['ulasan'],
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )),
                ),

                // Card(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       children: [
                //         Row(
                //           children: [
                //             Container(
                //               width: 7,
                //               height: 30,
                //               decoration: BoxDecoration(
                //                 color: const Color(0xffCABDFF),
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //             ),
                //             const SizedBox(width: 10.0),
                //             const Text(
                //               "Notification",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20,
                //                 color: Color(0xff172B4D),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          // BOTTOM NAVIGATION BAR
          bottomNavigationBar: (user['role'] == 'ahli servis' || user['role'] == 'admin'
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
                      title: const Text("Notif"),
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
      },
    );
  }
}
