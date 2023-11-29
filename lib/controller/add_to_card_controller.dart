
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  RxList cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
  }

  void removeFromCart(Map<String, dynamic> product) {
    cartItems.remove(product);
  }
}