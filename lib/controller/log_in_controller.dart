import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_page.dart';
import '../pages/log_in_page.dart';
import '../pages/all_product_gridview_page.dart';

class LogInController extends GetxController {
  var token = "".obs;


// Function to save only the token to SharedPreferences
  Future<void> saveToken(String tokan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", tokan);
    // Update the value of the observable
    token.value = tokan;
  }

// Function to load only the token from SharedPreferences
  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the token from SharedPreferences
    String loadedToken = prefs.getString("token") ?? "";
    // Update the value of the observable
    token.value = loadedToken;
    // Return the loaded token
    return loadedToken;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    token.value = '';
  }

  Future<void> login(String email, String password) async {
    try {
      final url = "https://demo.alorferi.com/oauth/token";
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
        await saveToken(tokan); // Save the token to SharedPreferences
        // Get.offAll(() => token.value.isEmpty ? LogInPage() : HomePage());
        refresh();
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
