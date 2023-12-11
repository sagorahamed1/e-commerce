import 'package:alorferi_app_practice/modeles/token_shareprefe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_to_card_controller.dart';
import '../controller/all_product_controller.dart';
import '../widgets/product_gridview.dart';

class AllProductGridViewPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  AddToCartController addToCartController = Get.put(AddToCartController());
  ScrollController scrollController = ScrollController();

  AllProductGridViewPage() {
    // Constructor Fetch data when we go to this widgetx
    productController.suggestions();
    productController.getProducts();

    // loading new data when the user scrolls down
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        productController.loadMore();
        print("load more data");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (productController.isLoading.value &&
            productController.currentPage == 1) {
          // Display a loading indicator only when the first page is being loaded
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
            controller: scrollController,
            itemCount: productController.suggestions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              if (index < productController.suggestions.length) {
                var product = productController.suggestions[index];
                return ProductGridView(
                    product: product, addToCartController: addToCartController);
              } else{
                return const Center(
                  child: null,
                ) ;
              }
            },
          );
        }
      }),
    );
  }
}
