import 'package:alorferi_app_practice/controller/all_product_controller.dart';
import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:alorferi_app_practice/controller/profile_controller.dart';
import 'package:alorferi_app_practice/pages/log_in_page.dart';
import 'package:alorferi_app_practice/pages/product_by_id_details_page.dart';
import 'package:alorferi_app_practice/pages/profile_page.dart';
import 'package:alorferi_app_practice/modeles/token_shareprefe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/url.dart';
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
  ProfileController profileController = Get.put(ProfileController());
  ProductController productController = Get.put(ProductController());

  // tabController dara bodir satha action set kora hoice
  late TabController _tabController;

  @override
  void initState() {
    AllProductGridViewPage();
    addToCartController.cartItems;
    _tabController = TabController(length: 3, vsync: this);
    profileController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileData = profileController.profile;
    TextEditingController text = TextEditingController();
    return Scaffold(
      // app bar practice tap bar practice example and controller diya body ak ak action er sathe link kora hoice
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        // centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Text(
          "BD Shop",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          /// search bar
          Container(
            padding: EdgeInsets.only(left: 5),
            height: 30,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: text,
              onChanged: (text) {
                productController.searchProducts(text);
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  border: InputBorder.none, suffixIcon: Icon(Icons.search)),
            ),
          ),

          /// shoping card
          IconButton(
            icon: Badge(
                label:
                    Obx(() => Text("${addToCartController.cartItems.length}")),
                child: Icon(
                  Icons.shopping_cart,
                )),
            onPressed: () {
              // Navigate to the cart page when the cart icon is pressed
              Get.to(() => AddToCartProductPage(),
                  transition: Transition.zoom,
                  duration: Duration(microseconds: 570000));
            },
          ),
        ],
      ),

      /// botom lav bar
      bottomNavigationBar: Material(
        color: Colors.cyan,
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
            Tab(
              icon: Icon(Icons.person),
              text: "profile",
            ),
          ],
        ),
      ),

      /// controll tab for protiqualar page
      body: TabBarView(controller: _tabController, children: [
        Container(child: AllProductGridViewPage()),
        Container(child: SellerGridViewPage()),
        Container(child: ProfilePage()),
      ]),

      ///Drawer part
      drawer: Drawer(
        child: ListView(
          children: [
            /// Drawer header part
            Obx(
              () => profileController.profile.value.isEmpty
                  ? Text("")
                  : DrawerHeader(
                      padding: EdgeInsets.all(0),
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.cyan),
                        accountName: Text(profileData['name']),
                        accountEmail: Text(profileData['email']),
                        onDetailsPressed: () {
                          Get.back();
                        },
                        currentAccountPicture: CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage(
                              "${Urls.baseUrl}${profileData["url"]}"),
                        ),
                      )),
            ),

            /// drawer body part
            ListTile(
              onTap: () {
                Get.to(MyProductsCrudPage(),
                    transition: Transition.zoom,
                    duration: Duration(microseconds: 570000));
              },
              title: Text("My Products"),
              leading: Icon(Icons.production_quantity_limits),
            ),

            ListTile(
              onTap: () {
                Get.to(ProfilePage(),
                    transition: Transition.zoom,
                    duration: Duration(microseconds: 570000));
              },
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
                  child: Text("Theme")),
            ),

            /// log out
            ListTile(
              onTap: () {
                Get.defaultDialog(
                    title: "Are You Sure",
                    middleText: "Do you want to Leave this site",
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Later")),
                      ElevatedButton(
                          onPressed: () {
                            TokenSharePrefences.logout();
                            Get.offAll(() => LogInPage());
                          },
                          child: Text("Yes")),
                    ]);
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
