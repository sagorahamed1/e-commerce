import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'controller/add_to_card_controller.dart';
import 'pages/home_page.dart';
import 'pages/log_in_page.dart';

void main()async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  LogInController logInController = Get.put(LogInController());

  MYApp(){
    LogInController();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: "/LogInPage",
      getPages: [
        // GetPage(name: "/LogInPage", page: () => LogInPage()),
        GetPage(name: "/HomePage", page: () => HomePage())
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Using a ternary operator to conditionally choose the initial page
       home: Obx(() => logInController.token.isEmpty? LogInPage() : HomePage()),
    );
  }
}
