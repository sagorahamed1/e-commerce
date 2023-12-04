import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartController extends GetxController {
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved cart items on initialization
    loadCartItems();
  }

  void addToCart(Map<String, dynamic> product) {
    final existingProductIndex = cartItems.indexWhere((item) => item["id"] == product["id"]);

    if (existingProductIndex != -1) {
      cartItems[existingProductIndex]["quantity"]++;
    } else {
      product["quantity"] = 1;
      cartItems.add(product);
    }
    update();
    saveCartItems();
  }


  void removeFromCart(Map<String, dynamic> product) {
    final existingProductIndex = cartItems.indexWhere((item) => item["id"] == product["id"]);

    if (existingProductIndex != -1) {
      cartItems[existingProductIndex]["quantity"] -= 1;

      if (cartItems[existingProductIndex]["quantity"] <= 0) {
        cartItems.removeAt(existingProductIndex);
      }
    }
    update();
    saveCartItems();
  }

  void clearCart() {
    cartItems.clear();
    update();
    saveCartItems();
  }

  double getTotalAmount() {
    double total = 0;
    for (var item in cartItems) {
      total += item["price"] * item["quantity"];
    }
    return total;
  }

  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = jsonEncode(cartItems.toList());
    prefs.setString('cartItems', cartItemsJson);
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = prefs.getString('cartItems');

    if (cartItemsJson != null) {
      final List<dynamic> decodedCartItems = jsonDecode(cartItemsJson);
      cartItems.assignAll(decodedCartItems.cast<Map<String, dynamic>>());
    }
  }
}
