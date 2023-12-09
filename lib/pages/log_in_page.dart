import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_up_page.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  LogInController logInController = Get.put(LogInController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = "";
  bool isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC5D3F5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "WelCome",
                  style: TextStyle(fontSize: 40),
                ),

                Center(
                  child: Container(
                    height: 180,
                    width: 280,
                    child: Image.asset(
                      "assets/shoping.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: emailController,
                  onChanged: (value) => _validateEmail(),
                  decoration: InputDecoration(
                      errorText: isEmailValid
                          ? null
                          : 'Your email address is not carrect!',
                      label: Text("Enter you email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13))),
                ),

                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      label: Text("Enter you password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13))),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: Text("Ramamber me")),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpPage());
                      },
                      child: Text("Forgot Password"),
                    )
                  ],
                ),

                /// give an error message!
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                ElevatedButton(
                    onPressed: () {
                      checkValidInfomaition();
                      _logIn();
                    },
                    child: Text("Log In")),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("You don't have an acount?"),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpPage());
                      },
                      child: Text(
                        "     Sign Up",
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logIn() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    logInController.login(email, password);
  }

  /// check real user
  void checkValidInfomaition() {
    if (_validateFields() && isEmailValid) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          emailController.clear();
          passwordController.clear();
          errorMessage = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: logInController.token.value.isEmpty
                ? Text("The user credentials were incorrect. try again",style: TextStyle(color: Colors.red),)
                : Text('logIn successful!'),
            duration: Duration(seconds: 1),
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
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all the fields.';
      });
      return false;
    }
    setState(() {
      errorMessage = '';
    });
    return true;
  }
}
