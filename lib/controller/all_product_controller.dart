import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../constants/url.dart';

class ProductController extends GetxController {
  var products = [].obs;
  var suggestions = [].obs;
  RxBool isLoading = false.obs;
  int currentPage = 1;

  Future<void> loadMore() async {
    currentPage++;
    await getProducts(isLoadMore: true);
  }


  @override
  void onInit() {
    super.onInit();
    getProducts();
    searchProducts("");
  }


  Future<void> getProducts({bool isLoadMore = false}) async {
    try {
      if (!isLoadMore) {
        isLoading.value = true;
        currentPage = 1;
      }

      isLoading.value = true;
      final url = Uri.parse("${Urls.allProductUrl}?page=$currentPage");
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
        refresh();
        print("Product fetch successful");
      } else {
        print("Products fetch failed");
      }
    } catch (e) {
      print("Error: $e");

    }
  }


  /// searching
  void searchProducts(String text) {
    print("==================================>> $products");
    text.isEmpty?
        suggestions.value = products:
        suggestions.value = products
        .where((product) =>
        product['name']
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()))
        .toList();
    update();
  }
}