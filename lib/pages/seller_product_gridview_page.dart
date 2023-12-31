import 'package:alorferi_app_practice/controller/add_to_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/seller_controller.dart';
import 'add_to_card_product_page.dart';

class SellerProductGridViewPage extends StatelessWidget {
  final String sellerId;

  AddToCartController addToCartController = Get.put(AddToCartController());
  SellerController sellerController = Get.put(SellerController());
  ScrollController scrollController = ScrollController();

  SellerProductGridViewPage({required this.sellerId}) {
    sellerController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        sellerController.isLoadMore();
      }
    });
    // Constructor - Fetch seller products when the widget is created
    sellerController.sellerProduct(sellerId);
    sellerController.getSeller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Products'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (sellerController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                return Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    itemCount: sellerController.sellerProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 6,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      if (index < sellerController.sellerProducts.length) {
                        var product = sellerController.sellerProducts[index];
                        return ProductCard(product: product);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductCard({Key? key, required this.product}) : super(key: key);

  AddToCartController addToCartController = Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Color(0xFFdbdff7),
      child: InkWell(
        onTap: () {
          // Handle product tap
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: product["url"] == null
                  ? Image.network(
                      "https://demo.alorferi.com/images/blank_product_picture.png")
                  : Image.network(
                      "https://demo.alorferi.com${product["url"]}",
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${product["name"]}",
                    style: TextStyle(fontWeight: FontWeight.w700),
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          "৳ ${product["price"]}",
                          overflow: TextOverflow
                              .ellipsis, // Optional: handle overflow with ellipsis
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "In Stock: ${product['stock_quantity']}",
                          overflow: TextOverflow
                              .ellipsis, // Optional: handle overflow with ellipsis
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        addToCartController.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Product added to cart successful')));
                      },
                      child: SizedBox(
                          height: 63,
                          width: 150,
                          child: Image.asset("assets/add_to_card_image.png")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
