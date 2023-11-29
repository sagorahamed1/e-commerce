// import 'package:alorferi_app_practice/controller/my_product_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/product_controller.dart';
// import '../widgets/product_gridview.dart';
//
// class MyProductGridViewPage extends StatelessWidget {
//
//
//   MyProductController myProductController = Get.put(MyProductController());
//
//
//   MyProductGridViewPage() {
//     // Constructor - Fetch data when the widget is created
//     myProductController.getMyProducts();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() {
//               if (myProductController.isLoading.value) {
//                 return CircularProgressIndicator();
//               } else {
//                 return Expanded(
//                   child: GridView.builder(
//                     itemCount: myProductController.myProduct.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7),
//                     itemBuilder: (context, index) {
//                       var product = myProductController.myProduct[index];
//                       return ProductGridView(product: product);
//                     },
//                   ),
//                 );
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }