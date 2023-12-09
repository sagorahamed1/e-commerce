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
        onTap: (){
          Get.to(ProductByIdDetailsPage(id: product['id'], products: product,));
        },
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: product["url"] == null
                    ? Image.network(
                        "https://demo.alorferi.com/images/blank_product_picture.png")
                    : Image.network("https://demo.alorferi.com${product["url"]}"),
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
                        Text("৳ ${product["price"]}"),
                        Text("In Stock: ${product['stock_quantity']}")
                      ],
                    ),
                    InkWell(
                        onTap: ()async {
                          var token =await TokenSharePrefences.loadToken();
                          if(token == null){
                            Get.to(LogInPage());
                          }else{
                            addToCartController!.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Product added to cart successful')));
                          }
                        },
                        child: SizedBox(
                            height: 55,
                            width: 120,
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
