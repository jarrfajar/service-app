import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:service_app/app/controllers/page_index_controller.dart';
import 'package:service_app/app/routes/app_pages.dart';

import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
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
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
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
                                const Text(
                                  "Ahli Service",
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
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamAllUser(),
                  builder: (context, snapAllUser) {
                    if (snapAllUser.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: snapAllUser.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> user = snapAllUser.data!.docs[index].data();
                        return Card(
                          child: ListTile(
                            onTap: () => Get.toNamed(Routes.SELLER_STORE, arguments: user['uid']),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: NetworkImage(
                                user['image'] == ''
                                    ? "https://ui-avatars.com/api/?name=${user['name']}"
                                    : "${user['image']}",
                              ),
                            ),
                            title: Text(user['name']),
                            subtitle: Text(user['role']),
                          ),
                        );
                      },
                    );
                  }),
            ],
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

                    /// Likes
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.store),
                      title: const Text("Store"),
                      selectedColor: const Color(0xff6759FF),
                    ),

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

                    /// Likes
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.store),
                      title: const Text("Store"),
                      selectedColor: const Color(0xff6759FF),
                    ),

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
