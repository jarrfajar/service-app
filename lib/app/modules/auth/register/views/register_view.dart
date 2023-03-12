import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:service_app/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
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
                  'Sign Up!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Center(
                child: Text(
                  "Create account, it's free",
                  // maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
              Flexible(
                child: ListView(
                  children: [
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
                            controller: controller.name,
                            decoration: InputDecoration(
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              hintText: "Enter name",
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
                    const SizedBox(height: 10.0),
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
                        padding: const EdgeInsets.all(12.0),
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
                    Obx(
                      () => Padding(
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
                              controller: controller.passwordConfirm,
                              obscureText: controller.isHidden.value,
                              decoration: InputDecoration(
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                hintText: "Enter password confirmation",
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
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        authController.signUp(
                          name: controller.name.text,
                          email: controller.email.text,
                          password: controller.password.text,
                          passwordConfirm: controller.passwordConfirm.text,
                        );
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
                              "Sign Up",
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
                    "Already have an a account?",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  // Text(" Register now"),
                  TextButton(
                    // onPressed: () => Get.offAllNamed(Routes.LOGIN),
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Login In",
                      style: TextStyle(
                        color: Color(0xff6759FF),
                      ),
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
