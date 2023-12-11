import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:alorferi_app_practice/modeles/token_shareprefe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/all_product_gridview_page.dart';
import 'pages/home_page.dart';
import 'pages/log_in_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LogInController logInController = Get.put(LogInController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

       home: HomePage(),
    );
  }
}
