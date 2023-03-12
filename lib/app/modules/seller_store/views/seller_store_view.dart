import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_app/app/routes/app_pages.dart';

import '../controllers/seller_store_controller.dart';

class SellerStoreView extends GetView<SellerStoreController> {
  final uid = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Info Seller',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> user = snapshot.data!.data()!;

            var test = user["createAt"].toDate();

            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                              user['image'] == ''
                                  ? "https://ui-avatars.com/api/?name=${user['name']}"
                                  : "${user['image']}",
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(user['phone']),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: controller.streamJasa(uid),
                              builder: (context, snapjasa) {
                                if (snapjasa.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jasa produk',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "${snapjasa.data!.docs.length} jasa ",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              }),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: controller.streamPesanan(uid),
                              builder: (context, snap) {
                                if (snap.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                print(snap.data!.docs.length);
                                // Map<String, dynamic> user = snap.data!.docs;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pesanan',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "${snap.data!.docs.length} kali dipesan",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              }),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bergabung',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              // Text(
                              //   test,
                              //   style: const TextStyle(
                              //     fontSize: 5.0,
                              //   ),
                              // )
                              Text(
                                DateFormat("dd MMMM, yyyy").format(
                                  DateTime.parse(test.toString()),
                                ),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamJasa(uid),
                    builder: (context, snapProduk) {
                      if (snapProduk.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: snapProduk.data!.docs.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> produk = snapProduk.data!.docs[index].data();

                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: double.maxFinite,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          produk['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3, left: 10, right: 10),
                                      width: double.maxFinite,
                                      // decoration: const BoxDecoration(color: Colors.red),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            produk['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0,
                                              color: Color(0xff172B4D),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          const SizedBox(
                                            height: 3.0,
                                          ),
                                          Text(
                                            produk['price'],
                                            style: const TextStyle(
                                              color: Color(0xff172B4D),
                                              fontSize: 16.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () =>
                                  Get.toNamed(Routes.DETAIL_PRODUCT, arguments: snapProduk.data!.docs[index].id),
                            );
                          },
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            );
          }),
    );
  }
}
