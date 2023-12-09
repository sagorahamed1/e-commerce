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
  String errorMessage = '';
  bool isEmailValid = true;

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
            Text(
              "Registation",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              onChanged: (value) => _validateEmail(),
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
                errorText: isEmailValid ? null : 'Enter a valid email address',
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


            /// give a error message
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                checkValidInfomation();
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

  void checkValidInfomation() {
    if (_validateFields() && isEmailValid) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          userNameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmationController.clear();
          errorMessage = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup successful!'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }
  }

  void _validateEmail() {
    String email = emailController.text;
    bool isValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
    setState(() {
      isEmailValid = isValid;
    });
  }

  bool _validateFields() {
    if (userNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmationController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
      });
      return false;
    } else if (passwordController.text != confirmationController.text) {
      setState(() {
        errorMessage = 'Passwords do not match.';
      });
      return false;
    }
    setState(() {
      errorMessage = '';
    });
    return true;
  }
}
