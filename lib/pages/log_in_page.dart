import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends StatelessWidget {
   LogInPage({super.key});
  
  LogInController logInController = Get.put(LogInController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  label: Text("Enter you email"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13)
                  )
                ),
              ),


              SizedBox(height: 30,),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    label: Text("Enter you password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13)
                    )
                ),
              ),


              ElevatedButton(onPressed: (){
                _logIn();
              },
                  child: Text("Log In")),
              

              Obx(() => Text("token${logInController.token}"))

            ],
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
}
