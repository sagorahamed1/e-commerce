import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/seller_controller.dart';
import 'seller_product_gridview_page.dart'; // Import the SellerProductGridViewPage

class SellerGridViewPage extends StatelessWidget {
  SellerController sellerController = Get.put(SellerController());
  ScrollController _scrollController = ScrollController();

  SellerGridViewPage() {
    // Constructor - Fetch data when the widget is created
    sellerController.getSeller();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        sellerController.isLoadMore();
        print("===========================================load more data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Obx(() {
              if (sellerController.isLoading.value &&
                  sellerController.page == 1) {
                return CircularProgressIndicator();
              } else {
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: sellerController.sellers.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    if (index < sellerController.sellers.length) {
                      var product = sellerController.sellers[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Get.to(() => SellerProductGridViewPage(
                            sellerId: product["id"],
                          ));
                        },
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    sellerController.dispose();
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
