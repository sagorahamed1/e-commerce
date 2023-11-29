import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  int currentPage = 1;

  Future<void> loadMore() async {
    currentPage++;
    await getProducts(isLoadMore: true);
  }

  Future<void> getProducts({bool isLoadMore = false}) async {
    try {
      if (!isLoadMore) {
        isLoading.value = true;
        currentPage = 1;
      }

      isLoading.value = true;
      final url = Uri.parse("https://demo.alorferi.com/api/products?page=$currentPage");
      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> productData = responseData['data'];

        if (isLoadMore) {
          products.addAll(List.from(productData));
        } else {
          products.value = List.from(productData);
        }
        print("Product fetch successful");
      } else {
        print("Products fetch failed");
        // Handle errors or show a message to the user
      }
    } catch (e) {
      print("Error: $e");
      // Handle errors or show a message to the user
    }
  }
}