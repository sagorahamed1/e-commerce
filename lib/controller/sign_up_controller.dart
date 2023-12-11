import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {

  RxString message  = "".obs;

   Future<void> CreateUser(String name, String email, String password, String confirmpassword) async {
    try {
      var url = Uri.parse("https://demo.alorferi.com/api/register");
      var body ={
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmpassword
      };

      var response = await http.post(url, body: body);

      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var signUpData = jsonDecode(response.body);
        var signUpMessages = signUpData['data']['message'];
        message.value = signUpMessages;
        print("User create successful");
      } else {
        // Print more details about the response
        print("User create failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
