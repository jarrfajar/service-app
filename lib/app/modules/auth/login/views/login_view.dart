import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:service_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:service_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Center(
                child: Text(
                  'Hello Again!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Center(
                child: Text(
                  "Welcome back you've\nbeen missed!",
                  // maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Stack(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        hintText: "Enter email",
                        fillColor: Colors.white70,
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
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
                  child: Stack(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      TextFormField(
                        controller: controller.password,
                        obscureText: controller.isHidden.value,
                        decoration: InputDecoration(
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          hintText: "Enter password",
                          fillColor: Colors.white70,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                              child: Icon(
                                (controller.isHidden.isFalse
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                color: Colors.grey[500],
                              ),
                            ),
                            onTap: () => controller.isHidden.toggle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: TextButton(
              //     onPressed: () {
              //       Get.toNamed(Routes.RESET_PASSWORD);
              //     },
              //     child: const Text(
              //       "Recovery Password",
              //       textAlign: TextAlign.right,
              //       style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        authController.login(email: controller.email.text, password: controller.password.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff6759FF),
                        minimumSize: const Size.fromHeight(100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      child: (authController.isLoading.isTrue
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            )),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a member?",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  // Text(" Register now"),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.REGISTER),
                    child: const Text(
                      "Register now",
                      style: TextStyle(color: Color(0xff6759FF)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
