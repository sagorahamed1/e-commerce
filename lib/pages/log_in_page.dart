import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_up_page.dart';

class LogInPage extends StatelessWidget {
   LogInPage({super.key});
  
  LogInController logInController = Get.put(LogInController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
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
                SizedBox(height: 40,),
                Text("WelCome",style: TextStyle(fontSize: 40),),

                Center(
                  child: Container(
                    height: 180,
                    width: 280,
                    child: Image.asset("assets/shoping.png",fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: 40,),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){},
                        child: Text("Ramamber me")),
                    TextButton(onPressed: (){
                      Get.to(SignUpPage());
                    }, child: Text("Forgot Password"),)
                  ],
                ),


                ElevatedButton(onPressed: (){
                  _logIn();
                },
                    child: Text("Log In")),



                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("You don't have an acount?"),
                    TextButton(onPressed: (){
                      Get.to(SignUpPage());
                    }, child: Text("     Sign Up",style: TextStyle(color: Colors.green),),)
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
}
