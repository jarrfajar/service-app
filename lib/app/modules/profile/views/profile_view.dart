import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:service_app/app/controllers/page_index_controller.dart';
import 'package:service_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:service_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  AuthController authController = Get.find<AuthController>();
  PageIndexController pageIndexController = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamProfile(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> profile = snap.data!.data()!;
          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME USER
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
                                          "Profile",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color(0xff172B4D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    FilterChip(
                                      label: const Text("Edit Profile"),
                                      backgroundColor: Colors.white,
                                      shape: const StadiumBorder(
                                        side: BorderSide(
                                          color: Color.fromARGB(255, 223, 223, 223),
                                          width: 1,
                                        ),
                                      ),
                                      onSelected: (bool value) => Get.toNamed(Routes.EDIT_PROFILE, arguments: profile),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: NetworkImage(
                                      profile['image'] == ''
                                          ? "https://ui-avatars.com/api/?name=${profile['name']}"
                                          : "${profile['image']}",
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
                                        "${profile['name']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Chip(
                                        label: Text("${profile['role']}"),
                                        backgroundColor: const Color(0xfffb5ebcd),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      (profile['status'] == 'pending'
                          ? Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Anda telah mengajukan untuk menjadi ahli servis."),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text("Tunggu konfirmasi dari admin"),
                                      Chip(
                                        label: Text("${profile['status']}"),
                                        backgroundColor: Colors.yellow,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container()),

                      // PROFILE USER
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // EMAIL
                              const Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
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
                                    // controller: controller.email,
                                    decoration: InputDecoration(
                                      filled: true,
                                      enabled: false,
                                      hintStyle: TextStyle(color: Colors.grey[500]),
                                      hintText: "${profile['email']}",
                                      fillColor: const Color(0xfffF5F5F5),
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
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              // PHONE NUMBER
                              (profile['role'] == 'ahli servis' || profile['role'] == 'admin'
                                  ? const Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Container()),
                              const SizedBox(height: 10.0),
                              (profile['role'] == 'ahli servis' || profile['role'] == 'admin'
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        TextFormField(
                                          // controller: controller.email,
                                          decoration: InputDecoration(
                                            filled: true,
                                            enabled: false,
                                            hintStyle: TextStyle(color: Colors.grey[500]),
                                            hintText: (profile['phone'] == null ? "Not Set" : "${profile['phone']}"),
                                            fillColor: const Color(0xfffF5F5F5),
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
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    )
                                  : Container()),
                              const SizedBox(height: 10.0),

                              // ADDRESS
                              (profile['role'] == 'ahli servis' || profile['role'] == 'admin'
                                  ? const Text(
                                      "Address",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Container()),
                              const SizedBox(height: 10.0),
                              (profile['role'] == 'ahli servis' || profile['role'] == 'admin'
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        TextFormField(
                                          // controller: controller.email,
                                          decoration: InputDecoration(
                                            filled: true,
                                            enabled: false,
                                            hintStyle: TextStyle(color: Colors.grey[500]),
                                            hintText:
                                                (profile['address'] == null ? "Not Set" : "${profile['address']}"),
                                            fillColor: const Color(0xfffF5F5F5),
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
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    )
                                  : Container()),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ALL USER
                  (profile['role'] == 'admin'
                      ? Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Stack(
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
                                          "User",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color(0xff172B4D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    FilterChip(
                                      label: const Text("See All"),
                                      backgroundColor: Colors.white,
                                      shape: const StadiumBorder(
                                        side: BorderSide(
                                          color: Color.fromARGB(255, 223, 223, 223),
                                          width: 1,
                                        ),
                                      ),
                                      onSelected: (bool value) => Get.toNamed(Routes.USER),
                                    ),
                                  ],
                                ),
                                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                    stream: controller.streamAllUser(),
                                    builder: (context, snapAllUser) {
                                      if (snapAllUser.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            (snapAllUser.data!.docs.length >= 5 ? 5 : snapAllUser.data!.docs.length),
                                        itemBuilder: (context, index) {
                                          // print(snapAllUser.data!.data()!.length);"https://ui-avatars.com/api/?name=${profile['name']}"
                                          Map<String, dynamic> user = snapAllUser.data!.docs[index].data();
                                          return ListTile(
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
                                          );
                                        },
                                      );
                                    }),
                              ],
                            ),
                          ),
                        )
                      : Container()),

                  // TOKO/JASA SERVICE
                  (profile['role'] == 'user')
                      ? Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text("Buat jasa servis"),
                                  content: Form(
                                    // key: secondPageController.addTipeKamarFormKey,
                                    // autovalidateMode: AutovalidateMode.always,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        // PHONE NUMBER
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          margin: const EdgeInsets.only(),
                                          child: TextFormField(
                                            controller: controller.phone,
                                            keyboardType: TextInputType.number,
                                            maxLength: 13,
                                            decoration: const InputDecoration(
                                              labelText: 'Phone number',
                                              labelStyle: TextStyle(
                                                color: Colors.blueGrey,
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                              helperText: "Enter phone number!",
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        ),

                                        // ADDRESS
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          margin: const EdgeInsets.only(),
                                          child: TextFormField(
                                            controller: controller.address,
                                            maxLength: 100,
                                            decoration: const InputDecoration(
                                              labelText: 'Address',
                                              labelStyle: TextStyle(
                                                color: Colors.blueGrey,
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                              helperText: "Enter address!",
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
                                        backgroundColor: Colors.white,
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
                                          backgroundColor: const Color(0xff6759FF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ), // <-- Radius
                                          ),
                                        ),
                                        onPressed: () {
                                          controller.buatJasaServis(
                                            uid: profile['uid'],
                                            phone: controller.phone.text,
                                            address: controller.address.text,
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
                                            : const Text("Buat jasa")),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              "Buat jasa servis",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        )
                      : Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
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
                                          "Jasa servis kamu",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color(0xff172B4D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    FilterChip(
                                      label: const Text("See All"),
                                      backgroundColor: Colors.white,
                                      shape: const StadiumBorder(
                                        side: BorderSide(
                                          color: Color.fromARGB(255, 223, 223, 223),
                                          width: 1,
                                        ),
                                      ),
                                      onSelected: (bool value) => Get.toNamed(Routes.SERVIS),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                height: 275,
                                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                    stream: controller.streamService(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Center(child: Text("Tidak ada jasa servis")),
                                            FilterChip(
                                              label: const Text("Buat jasa servis"),
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
                                        );
                                      }

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: (snapshot.data!.docs.length >= 6 ? 6 : snapshot.data!.docs.length),
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> service = snapshot.data!.docs[index].data();

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 154,
                                                  width: 139,
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
                                                const SizedBox(height: 5.0),
                                                SizedBox(
                                                  width: 139,
                                                  child: Text(
                                                    "${service['name']}",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                const SizedBox(height: 5.0),
                                                Text(
                                                  "${service['price']}",
                                                  style: const TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                Chip(
                                                  label: (service['status'] == 'tersedia'
                                                      ? const Text("Tersedia")
                                                      : const Text("Tidak tersedia")),
                                                  backgroundColor: (service['status'] == 'tersedia'
                                                      ? const Color(0xfffb5ebcd)
                                                      : const Color(0xffffb9b9b)),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),

                  // SEMUA SERVICE
                  (profile['role'] == 'admin'
                      ? Card(
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
                                          "Semua Service",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color(0xff172B4D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    FilterChip(
                                      label: const Text("See All"),
                                      backgroundColor: Colors.white,
                                      shape: const StadiumBorder(
                                        side: BorderSide(
                                          color: Color.fromARGB(255, 223, 223, 223),
                                          width: 1,
                                        ),
                                      ),
                                      onSelected: (bool value) => Get.toNamed(Routes.ALL_SERVICE),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container()),

                  // LOGOUT
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            content: const Text('Anda yakin ingin keluar dari akun ini?'),
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff6759FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ), // <-- Radius
                                  ),
                                ),
                                onPressed: () {
                                  authController.signOut();
                                  pageIndexController.pageIndex.value = 0;
                                },
                                child: const Text("Keluar"),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                      ),
                      child: const Text(
                        "Keluar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM NAVIGATION BAR
            bottomNavigationBar: (profile['role'] == 'ahli servis' || profile['role'] == 'admin'
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
