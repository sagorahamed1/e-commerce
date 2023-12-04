import 'package:alorferi_app_practice/pages/log_in_page.dart';
import 'package:alorferi_app_practice/token_shareprefe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_to_card_controller.dart';
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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar practice tap bar practice example and controller diya body ak ak action er sathe link kora hoice
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Text(
          "E-commerce App",
          style: TextStyle(color: Colors.black),
        ),
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

              ///AddToCartProductPage());
            },
          ),
        ],
      ),

      /// botom lav bar
      bottomNavigationBar: Material(
        color: Colors.pink,
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.groups),
              text: "Seller",
            ),
          ],
        ),
      ),

      /// controll tab for protiqualar page
      body: TabBarView(controller: _tabController, children: [
        Container(child: AllProductGridViewPage()),
        Container(child: SellerGridViewPage()),
      ]),





      ///Drawer part
      drawer: Drawer(
        child: ListView(
          children: [

            /// Drawer header part
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.pinkAccent),
                accountName: Text('Sagor Ahammed'),
                accountEmail: Text('sagor@gmail.com'),
                onDetailsPressed: () {
                  Get.back();
                },
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://demo.alorferi.com/storage/images/0a929a56-64e4-4a5a-a1a8-d30f61492ab7.jpg",
                  ),
                ),
              ),
            ),



            /// drawer body part
            ListTile(
              onTap: () {
                Get.to(MyProductsCrudPage());
              },
              title: Text("My Products"),
              leading: Icon(Icons.production_quantity_limits),
            ),

            ListTile(
              onTap: () {},
              title: Text("Profile"),
              leading: Icon(Icons.person),
            ),



            ///theme change
            ListTile(
              leading: Icon(Icons.light_mode),
              title: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.light_mode),
                              title: Text("Light Mode"),
                              onTap: () {
                                Get.changeTheme(ThemeData.light());
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.dark_mode),
                              title: Text("Dark Mode"),
                              onTap: () {
                                Get.changeTheme(ThemeData.dark());
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text("Buttom Sheets")),
            ),



            /// log out
            ListTile(
              onTap: () {
                Get.defaultDialog(
                    title: "Are You Sure",
                    middleText: "Do you want to Leave this site",
                    actions: [
                      ElevatedButton(onPressed: (){
                        Get.back();
                      },
                          child: Text("Later")
                      ),

                      ElevatedButton(onPressed: (){
                        TokenSharePrefences.logout();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LogInPage()));
                      },
                          child: Text("Yes")
                      ),
                    ]
                );
              },
              title: Text(
                "Log Out",
                style: TextStyle(color: Colors.red),
              ),
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
            ),



          ],
        ),
      ),
    );
  }
}
