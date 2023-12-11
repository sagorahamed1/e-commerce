import 'dart:convert';
import 'dart:io';
import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:alorferi_app_practice/modeles/token_shareprefe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/url.dart';



class MyProductController extends GetxController {
  RxList myProduct = [].obs;
  RxBool isLoading = false.obs;

   var loginController = Get.find<LogInController>();
  // static const String apiUrl = "https://demo.alorferi.com/api/my-products";
  static const String apiUrl = "${Urls.myProductUrl}";

  @override
  void onInit() {
    super.onInit();
     loginController;
    getMyProducts();
  }


  /// fetch my products
  Future<void> getMyProducts() async {
    try {
      var token = await TokenSharePrefences.loadToken();
       isLoading.value = true;

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
       isLoading.value = false;

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List productData = responseData['data'];
        myProduct.value = List.from(productData);
        print("Product fetch successful");
        refresh();
        update();
      } else {
        print("Products fetch failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error =============================>: $e ");
    }
  }



  /// delete product method
  Future<void> deleteProduct(String id) async {
    try {
      isLoading.value = true;
      var token = await TokenSharePrefences.loadToken();
      final response = await http.delete(
        Uri.parse('$apiUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );

      isLoading.value = false;
      if (response.statusCode != 204) {
        throw Exception('Delete product succuss ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }



  /// create new product
  Future<void> createProductWithImage( Map<String, dynamic> product, File? imageFile) async {
    try {
      isLoading.value = true;
      var token = await TokenSharePrefences.loadToken();
      var request = http.MultipartRequest('POST', Uri.parse("${apiUrl}"));
      request.headers['Authorization'] = 'Bearer $token';

      // Add product data to the request
      request.fields.addAll(product.map((key, value) => MapEntry(key, value.toString())));

      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      }

      var response = await request.send();

      isLoading.value = false;
      if (response.statusCode == 201) {
        print('Product created successful');
      } else {
        print('Failed to create product adn Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error creating product: $error');
    }
  }




  /// update product
  Future<void> updateProduct(String id, Map<String, dynamic> updatedProduct, File? imageFile) async {
    try {
      isLoading.value = true;
      var token = await TokenSharePrefences.loadToken();
      var request = await http.MultipartRequest('POST', Uri.parse("${apiUrl}/${id}?_method=PUT"));
      request.headers['Authorization'] = 'Bearer $token';

      // Add product data to the request
      request.fields.addAll(updatedProduct.map((key, value) => MapEntry(key, value.toString())));

      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      }

      var response = await request.send();

      isLoading.value = false;
      if (response.statusCode == 201) {
        print('Product created successful');
      } else {
        print('Failed to create product and Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error creating product: $error');
    }
  }

}



