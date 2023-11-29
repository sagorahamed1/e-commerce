import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/seller_controller.dart';
import 'seller_product_gridview_page.dart'; // Import the SellerProductGridViewPage

class SellerGridViewPage extends StatelessWidget {
  SellerController sellerController = Get.put(SellerController());

  SellerGridViewPage() {
    // Constructor - Fetch data when the widget is created
    sellerController.getSeller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    itemCount: sellerController.sellers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      var product = sellerController.sellers[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          // When a seller is tapped, navigate to the SellerProductGridViewPage
                          Get.to(() => SellerProductGridViewPage(
                            sellerId: product["id"],
                          ));
                        },
                      );
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
  final VoidCallback onTap;

  const ProductCard({Key? key, required this.product, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: product["url"] == null
                  ?  Image.network("https://demo.alorferi.com/images/blank_product_picture.png")
                  : Image.network(
                "https://demo.alorferi.com${product["url"]}",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${product["name"]}", style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
