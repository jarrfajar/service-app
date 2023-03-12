import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:service_app/app/data/CurrencyFormat.dart';

import '../controllers/detail_service_controller.dart';
import 'package:intl/intl.dart';
// import 'package:currency_app/currecy_format.dart';

class DetailServiceView extends GetView<DetailServiceController> {
  final service = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.hargaAwal.value = service['price'].substring(3, 9).replaceAll('.', '');
    controller.total.value = service['price'].substring(3, 9).replaceAll('.', '');
    // ASGuUNUdJduXtwsZk51e
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              height: Get.height * 0.25,
              width: double.maxFinite,
              color: Colors.greenAccent,
              child: Image.network(
                service['image'] ?? "https://ui-avatars.com/api/?name=fajar",
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: Get.height * 0.19,
                          width: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 5),
                        child: GestureDetector(
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.arrow_back_rounded),
                          ),
                          onTap: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
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
                              Text(
                                service['name'],
                                // 'AC Repair',
                                style: const TextStyle(
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
                  ),

                  // JUMLAH UNIT
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Jumlah Unit",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
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
                                              : DateFormat('HH:mm').format(DateTime.parse(controller.time.value))),
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  // BILL
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.black,
                                    // backgroundColor: Colors.teal,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                    ),
                                    onPressed: () {
                                      controller.booking(
                                        serviceID: service.id,
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
                                            'Pesan',
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
