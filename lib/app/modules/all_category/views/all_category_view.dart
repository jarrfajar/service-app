import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_category_controller.dart';

class AllCategoryView extends GetView<AllCategoryController> {
  const AllCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
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
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                          "Category",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff172B4D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                            return const Center(child: Text("Tidak ada data"));
                          }

                          return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 4 / 2,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (_, int index) {
                              Map<String, dynamic> category = snapshot.data!.docs[index].data();

                              List colors = [
                                const Color(0xfffc944d),
                                const Color(0xfffcabdff),
                                const Color(0xfffb1e5fc),
                                const Color(0xfffb5ebcd),
                                const Color(0xfffffd88d),
                                const Color(0xfffcbeba4),
                                const Color(0xfffcbeba4),
                                const Color(0xffffb9b9b),
                                const Color(0xffffc944d),
                                const Color(0xfffafc6ff),
                              ];
                              Random random = Random();
                              int calor = random.nextInt(colors.length);

                              return Chip(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                label: Text("${category['name']}"),
                                backgroundColor: colors[calor],
                              );
                            },
                          );
                        })
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
