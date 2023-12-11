import 'package:alorferi_app_practice/pages/log_in_page.dart';
import 'package:alorferi_app_practice/pages/product_by_id_details_page.dart';
import 'package:alorferi_app_practice/token_shareprefe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_to_card_controller.dart';

class ProductGridView extends StatelessWidget {
  final Map<String, dynamic> product;
  final AddToCartController? addToCartController;

  ProductGridView({required this.product, this.addToCartController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Get.to(
              ProductByIdDetailsPage(
                id: product['id'],
                products: product,
              ),
              transition: Transition.zoom,
              duration: Duration(microseconds: 570000));
        },
        child: Card(
          color: Color(0xFFdbdff7),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: product["url"] == null
                    ? Image.network(
                        "https://demo.alorferi.com/images/blank_product_picture.png")
                    : Hero(
                        tag: product['id'],
                        child: Image.network(
                          "https://demo.alorferi.com${product["url"]}",
                          fit: BoxFit.cover,
                        )),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "   ${product["name"]}",
                        style: TextStyle(fontWeight: FontWeight.w900),
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            "৳ ${product["price"]}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "In Stock: ${product['stock_quantity']}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () async {
                          var token = await TokenSharePrefences.loadToken();
                          if (token == null) {
                            addToCartController!.addToCart(product);
                            Get.to(LogInPage());
                          } else {
                            addToCartController!.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Product added to cart successful')));
                          }
                        },
                        child: SizedBox(
                            height: 63,
                            width: 150,
                            child: Image.asset("assets/add_to_card_image.png")))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
