// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/crud_my_product_controller.dart';
//
// class MyProductEditForm extends StatelessWidget {
//   var product;
//   String? id;
//   MyProductEditForm({required this.product, this.id});
//
//   final CrudController crudController = CrudController();
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController priceController = TextEditingController();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Product"),
//       ),
//       body: Column(
//         children: [
//           Text("$id"),
//           Container(
//             height: 200,
//             width: 150,
//             color: Colors.cyan,
//             child: Text("Edit Image"),
//           ),
//           TextFormField(
//             controller: nameController,
//             // initialValue: product['name'],
//             decoration: InputDecoration(
//               labelText: "Product name",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           TextFormField(
//             controller: priceController,
//             // initialValue: product['price'],
//             decoration: InputDecoration(
//               labelText: "Product Price",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                   if (id != null) {
//                     crudController.updateProduct(
//                       product[id], // Use ! to assert that product[id] is not null
//                       {
//                         'name': nameController.text,
//                         'price': double.parse(priceController.text),
//                       },
//                     );
//                   } else {
//                     crudController.createProduct(product);
//                   }
//                 },
//                 child: Text("Save"),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
