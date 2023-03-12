import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
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
                            const SizedBox(
                              height: 10.0,
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
                                  "User",
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
                          stream: controller.streamUser(),
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
                                Map<String, dynamic> user = snapshot.data!.docs[index].data();

                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        icon: Icons.edit_calendar_rounded,
                                        backgroundColor: Colors.yellow,
                                        onPressed: (context) {
                                          // controller.name.text = service['name'];
                                          // controller.price.text = service['price'];
                                          // controller.desc.text = service['deskripsi'];

                                          // EDIT/UPDATE
                                          if (user['status'] == 'pending') {
                                            Get.dialog(
                                              AlertDialog(
                                                // title: const Text("Konfirmasi jasa servis"),
                                                content: Form(
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    children: const [
                                                      Text("Konfirmasi jasa servis"),
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
                                                        controller.konfirmasiServis(uid: snapshot.data!.docs[index].id);
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
                                                          : const Text("Setuju")),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            user['image'] == ''
                                                ? "https://ui-avatars.com/api/?name=${user['name']}"
                                                : "${user['image']}",
                                          ),
                                        ),
                                        title: Text(user['name']),
                                        subtitle: Text(user['role']),
                                        trailing: Chip(
                                          backgroundColor: user['status'] == ''
                                              ? Colors.greenAccent
                                              : user['status'] == 'pending'
                                                  ? Colors.yellow
                                                  : Colors.blue[200],
                                          label: Text(user['status'] == ''
                                              ? user['role']
                                              : user['status'] == 'pending'
                                                  ? 'pending'
                                                  : 'admin'),
                                        ),
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
                                    ],
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
