import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:service_app/app/controllers/page_index_controller.dart';
import 'package:service_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:service_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  AuthController authController = Get.find<AuthController>();
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${data['name']}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "APA YANG KAMU CARI?",
                            style: TextStyle(
                              fontSize: 28,
                              color: Color(0xff172B4D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SEARCH
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xf0f2f2f2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                TextFormField(
                                  // controller: controller.password,
                                  // obscureText: controller.isHidden.value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                    hintText: "Enter password",
                                    fillColor: const Color.fromARGB(239, 247, 247, 247),
                                    // fillColor: Colors.red,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                                  ),
                                  // onChanged: (value) {
                                  //   // controller.name.value = value;
                                  //   // print(controller.name.value);
                                  // },
                                  onChanged: (value) => controller.filterPlayer(value),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                                        child: Icon(Icons.search, size: 28),
                                      ),
                                      // onTap: () => controller.isHidden.toggle(),
                                      onTap: () {},
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
                ),

                // // CATEGORY
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Card(
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                //     child: Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                //           child: Stack(
                //             alignment: Alignment.centerRight,
                //             children: [
                //               Row(
                //                 children: [
                //                   Container(
                //                     width: 7,
                //                     height: 30,
                //                     decoration: BoxDecoration(
                //                       color: const Color(0xffCABDFF),
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                   const SizedBox(width: 10.0),
                //                   const Text(
                //                     "Category",
                //                     style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 20,
                //                       color: Color(0xff172B4D),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               FilterChip(
                //                 label: const Text("See All"),
                //                 backgroundColor: Colors.white,
                //                 shape: const StadiumBorder(
                //                   side: BorderSide(
                //                     color: Color.fromARGB(255, 223, 223, 223),
                //                     width: 1,
                //                   ),
                //                 ),
                //                 onSelected: (bool value) => Get.toNamed(Routes.ALL_CATEGORY),
                //               ),
                //             ],
                //           ),
                //         ),
                //         StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //             stream: controller.streamCategory(),
                //             builder: (context, snapshot) {
                //               if (snapshot.connectionState == ConnectionState.waiting) {
                //                 return const Center(child: CircularProgressIndicator());
                //               }
                //               if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                //                 return const Center(child: Text("Tidak ada data"));
                //               }
                //               return SizedBox(
                //                 height: 60,
                //                 child: ListView.builder(
                //                   shrinkWrap: true,
                //                   scrollDirection: Axis.horizontal,
                //                   itemCount: (snapshot.data!.docs.length >= 6 ? 6 : snapshot.data!.docs.length),
                //                   itemBuilder: (context, index) {
                //                     Map<String, dynamic> category = snapshot.data!.docs[index].data();
                //                     List colors = [
                //                       const Color(0xfffc944d),
                //                       const Color(0xfffcabdff),
                //                       const Color(0xfffb1e5fc),
                //                       const Color(0xfffb5ebcd),
                //                       const Color(0xfffffd88d),
                //                       const Color(0xfffcbeba4),
                //                       const Color(0xfffcbeba4),
                //                       const Color(0xffffb9b9b),
                //                       const Color(0xffffc944d),
                //                       const Color(0xfffafc6ff),
                //                     ];
                //                     Random random = Random();
                //                     int calor = random.nextInt(colors.length);

                //                     return Padding(
                //                       padding: const EdgeInsets.symmetric(horizontal: 10),
                //                       child: Chip(
                //                         padding: EdgeInsets.zero,
                //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //                         label: Text("${category['name']}"),
                //                         backgroundColor: colors[calor],
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               );
                //             }),
                //       ],
                //     ),
                //   ),
                // ),
                // // const SizedBox(height: 10.0),

                // HEADER JASA SERVIS
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
                                    "Jasa Service",
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
                const SizedBox(height: 5.0),

                Obx(
                  () => (controller.cariPemain.value.isEmpty
                      ? const Center(child: Text("Tidak ada data"))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: controller.cariPemain.value.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              // print(controller.cariPemain.value[index].id);
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
                                            controller.cariPemain.value[index]['image'] ??
                                                "https://ui-avatars.com/api/?name=fajar",
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
                                              controller.cariPemain.value[index]['name'],
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
                                              controller.cariPemain.value[index]['price'],
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
                                // onTap: () => print(controller.cariPemain.value[index]['name']),
                                onTap: () =>
                                    // Get.toNamed(Routes.DETAIL_SERVICE, arguments: controller.cariPemain.value[index]),
                                    Get.toNamed(Routes.DETAIL_PRODUCT,
                                        arguments: controller.cariPemain.value[index].id),
                              );
                            },
                          ),
                        )),
                ),
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

                      /// Likes
                      // SalomonBottomBarItem(
                      //   icon: const Icon(Icons.store),
                      //   title: const Text("Store"),
                      //   selectedColor: const Color(0xff6759FF),
                      // ),

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
