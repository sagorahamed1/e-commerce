import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_to_card_controller.dart';
import 'MyProductGridViewPage.dart';
import 'add_to_card_product_page.dart';
import 'my_pruduct_crud_page.dart';
import 'all_product_gridview_page.dart';
import 'seller_grid_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// singleticker... dara vsyne er this use kora hoi
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AddToCartController addToCartController = Get.put(AddToCartController());

  // tabController dara bodir satha action set kora hoice
  late TabController _tabController;

  @override
  void initState() {
    addToCartController.cartItems;
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar practice tap bar practice example and controller diya body ak ak action er sathe link kora hoice
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Text(
          "E-commerce App",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(Icons.menu),
        actions: [
          //for add to card
          Icon(Icons.person),

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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "All Products",
            ),
            Tab(
              text: "My Products",
            ),
            Tab(
              text: "Seller",
            ),
          ],
        ),
      ),

      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blueGrey),

          // tabVarView use korte hobe and tabController
          child: TabBarView(controller: _tabController, children: [
            Container(
                height: 200,
                width: 200,
                color: Colors.yellow,
                child: AllProductGridViewPage()),
            Container(
                height: 200,
                width: 200,
                color: Colors.red,
                child: MyProductsCrudPage()),
            Container(
                height: 200,
                width: 200,
                color: Colors.purple,
                child: SellerGridViewPage()),
          ])),
    );
  }
}
