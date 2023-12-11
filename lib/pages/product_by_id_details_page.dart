import 'package:alorferi_app_practice/controller/add_to_card_controller.dart';
import 'package:alorferi_app_practice/pages/add_to_card_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/url.dart';

class ProductByIdDetailsPage extends StatelessWidget {
  var id;
  var products;

  ProductByIdDetailsPage({super.key, required this.id, required this.products});

  AddToCartController addToCartController = Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products['name']),
        actions: [
          IconButton(
            icon: Badge(
                label:
                    Obx(() => Text("${addToCartController.cartItems.length}")),
                child: Icon(
                  Icons.shopping_cart,
                )),
            onPressed: () {
              // Navigate to the cart page when the cart icon is pressed
              Get.to(() => AddToCartProductPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),

              Container(
                  height: 280,
                  width: double.infinity,
                  child: products['url'] == null
                      ? Image.network(
                          "https://demo.alorferi.com/images/blank_product_picture.png")
                      : Hero(
                      tag: products['id'],
                      child: Image.network("${Urls.baseUrl}${products["url"]}"))),

              Text(
                "${products["name"]}",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),

              Text(
                "Price ৳ ${products["price"]}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              /// description of product manually
              Text("This is product description ${products['description']}\n Unleash productivity like never before with our dynamic range of laptops. Engineered for performance and efficiency, these portable powerhouses cater to every need, whether it's work, creativity, or entertainment. Immerse yourself in a world of seamless multitasking and crystal-clear visuals with our cutting-edge laptops."),

              /// rating star
              Text(
                "Customer Review",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                ],
              ),

              SizedBox(
                height: 25,
              ),

              ElevatedButton(
                  onPressed: () {
                    addToCartController!.addToCart(products);
                  },
                  child: Container(
                      height: 60,
                      width: 130,
                      child: Image.asset(
                        "assets/add_to_card_image.png",
                        fit: BoxFit.cover,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
