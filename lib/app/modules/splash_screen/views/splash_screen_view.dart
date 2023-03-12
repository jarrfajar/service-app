import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controller.checkinternet(),
        builder: (context, snap) {
          if (snap.data == true) {
            return const Center(
              child: Text(
                'MyApp',
                style: TextStyle(
                  fontSize: 42,
                  color: Color(0xff6759FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Lottie.asset('lotties/internet.json'),
                const Center(
                  child: Text(
                    "Tidak ada koneksi internet!",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff6759FF),
                    ),
                    onPressed: () {
                      controller.initTimer();
                    },
                    // onPressed: _checkinternet,
                    child: const Text('Coba lagi'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xfffb9b9b),
                    ),
                    onPressed: () => exit(0),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
