import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:service_app/app/routes/app_pages.dart';

import '../controllers/servis_controller.dart';

class ServisView extends GetView<ServisController> {
  const ServisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                FilterChip(
                                  label: const Text("Tambah Jasa"),
                                  backgroundColor: Colors.white,
                                  shape: const StadiumBorder(
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 223, 223, 223),
                                      width: 1,
                                    ),
                                  ),
                                  onSelected: (bool value) => Get.toNamed(Routes.TAMBAH_SERVIS),
                                )
                              ],
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
                                  "Jasa servis kamu",
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
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 0),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.streamService(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                              return const Center(child: Text("Tidak ada data"));
                            }

                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> service = snapshot.data!.docs[index].data();

                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        icon: Icons.edit_calendar_rounded,
                                        backgroundColor: Colors.yellow,
                                        onPressed: (context) {
                                          controller.name.text = service['name'];
                                          controller.price.text = service['price'];
                                          controller.desc.text = service['deskripsi'];

                                          // EDIT/UPDATE
                                          Get.dialog(
                                            AlertDialog(
                                              title: const Text("Update Service"),
                                              content: Form(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    // NAME
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                      margin: const EdgeInsets.only(),
                                                      child: TextFormField(
                                                        controller: controller.name,
                                                        maxLines: null,
                                                        keyboardType: TextInputType.multiline,
                                                        decoration: const InputDecoration(
                                                          labelText: 'name',
                                                          labelStyle: TextStyle(
                                                            color: Colors.blueGrey,
                                                          ),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blueGrey,
                                                            ),
                                                          ),
                                                          helperText: "Enter nama!",
                                                        ),
                                                        onChanged: (value) {},
                                                      ),
                                                    ),

                                                    // DESC
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                      margin: const EdgeInsets.only(),
                                                      child: TextFormField(
                                                        controller: controller.desc,
                                                        maxLines: null,
                                                        keyboardType: TextInputType.multiline,
                                                        decoration: const InputDecoration(
                                                          labelText: 'description',
                                                          labelStyle: TextStyle(
                                                            color: Colors.blueGrey,
                                                          ),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blueGrey,
                                                            ),
                                                          ),
                                                          helperText: "Enter desc!",
                                                        ),
                                                        onChanged: (value) {},
                                                      ),
                                                    ),

                                                    // PRICE
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                      margin: const EdgeInsets.only(),
                                                      child: TextFormField(
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
                                                        decoration: const InputDecoration(
                                                          labelText: 'Price',
                                                          labelStyle: TextStyle(
                                                            color: Colors.blueGrey,
                                                          ),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blueGrey,
                                                            ),
                                                          ),
                                                          helperText: "Enter price!",
                                                        ),
                                                        onChanged: (value) {},
                                                      ),
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
                                                      controller.updateService(
                                                        uid: snapshot.data!.docs[index].id,
                                                        name: controller.name.text,
                                                        price: controller.price.text,
                                                      );
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
                                                        : const Text("Update")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      SlidableAction(
                                        icon: Icons.delete_forever,
                                        backgroundColor: Colors.red,
                                        onPressed: (context) {
                                          // DELETE
                                          Get.dialog(
                                            AlertDialog(
                                              title: const Text("Delete Service"),
                                              content: Text("Anda yakin ingin menghapus ${service['name']}"),
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
                                                      controller.deleteService(uid: snapshot.data!.docs[index].id);
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
                                                        : const Text("Delete")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 116,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              service['image'] ?? "https://ui-avatars.com/api/?name=fajar",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${service['name']}",
                                                // controller.search,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              const SizedBox(height: 10.0),
                                              const Text(
                                                "Mulai dari",
                                                style: TextStyle(fontSize: 15.0),
                                              ),
                                              Row(
                                                children: [
                                                  Chip(
                                                    label: Text("${service['price']}"),
                                                    backgroundColor: const Color(0xfffb1e5fc),
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
