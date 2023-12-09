import 'dart:convert';
import 'package:alorferi_app_practice/token_shareprefe.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/url.dart';
import '../pages/home_page.dart';

class LogInController extends GetxController {
  var token = "".obs;
  var errorMessage = "".obs;


  Future<void> login(String email, String password) async {
    try {
      // final url = "https://demo.alorferi.com/oauth/token";
      final url = "${Urls.logInUrl}";
      var response = await http.post(Uri.parse(url), body: {
        "grant_type": "password",
        "client_id": "2",
        "client_secret": "Cr1S2ba8TocMkgzyzx93X66szW6TAPc1qUCDgcQo",
        "username": email,
        "password": password
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var tokan = data["access_token"];
        token.value = data["access_token"];

       await TokenSharePrefences.saveToken(tokan);
         Get.offAll(() => HomePage());
        refresh();
      }else if(response.statusCode == 400){
        var data = jsonDecode(response.body);
        print(data);
        errorMessage.value = data['error'];
      } else {
        print("Login failed. Status code: ${response.statusCode}");
        // You might want to show a snackbar or display an error message here
      }
    } catch (e) {
      print("Error: $e");
      // Handle other types of errors (e.g., network issues)
    }
  }
}
