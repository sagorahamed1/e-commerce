import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_to_card_controller.dart';

class AddToCartProductPage extends StatelessWidget {
  final AddToCartController cartController = Get.find<AddToCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("Check out"),
      ),
      body: Center(
        child: Obx(() {
          var cartItems = cartController.cartItems;
          if (cartItems.isEmpty) {
            return Text('Your cart is empty');
          } else {
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var cartItem = cartItems[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: cartItem["url"] == null
                        ? Image.network("https://demo.alorferi.com/images/blank_product_picture.png")
                        : Image.network("https://demo.alorferi.com${cartItem['url']}"),
                    title: Text(cartItem['name']),
                    subtitle: Text('Price: ৳ ${cartItem['price']}'),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
