import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  SignUpController signUpController = Get.put(SignUpController());
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationController = TextEditingController();
  var isSecure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC5D3F5),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 120),
            Text("Registation", style: TextStyle(fontSize: 30),),
            SizedBox(height: 50,),
            TextFormField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: "Enter your Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            Obx(() => TextFormField(
              controller: passwordController,
              obscureText: isSecure.value,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    isSecure.value = !isSecure.value;
                  },
                  child: Icon(
                    isSecure.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                labelText: "Enter your Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )),
            SizedBox(height: 16),
            Obx(() => TextFormField(
              controller: confirmationController,
              obscureText: isSecure.value,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    isSecure.value = !isSecure.value;
                  },
                  child: Icon(
                    isSecure.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                labelText: "Confirm your Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                signUpController.CreateUser(
                  userNameController.text,
                  emailController.text,
                  passwordController.text,
                  confirmationController.text,
                );
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
