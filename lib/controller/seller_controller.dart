import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SellerController extends GetxController {

  var sellers = <Map<String, dynamic>>[].obs;
  var sellerProducts = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    getSeller();
    // sellerProduct(sellers as String);
    sellerProduct(sellers.isEmpty ? "" : sellers[0]["id"]);
  }

  Future<void> getSeller() async {
    try {
      isLoading.value = true;
      final url = Uri.parse("https://demo.alorferi.com/api/users");
      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> SellerData = responseData['data'];
        sellers.value = List.from(SellerData);
        print("Seller fetch successful");
      } else {
        print("Sellers fetch failed");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> sellerProduct(String sellerId) async {
    try {
      isLoading.value = true;
      final url = Uri.parse("https://demo.alorferi.com/api/users/$sellerId/products");
      var response = await http.get(url);
      isLoading.value = false;

      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> sellerProductsData = responseData['data'];
        sellerProducts.value = List.from(sellerProductsData);
        print("Seller products fetch successful");
        refresh();
      } else {
        print("Seller products fetch failed");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
