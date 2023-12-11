import 'dart:convert';
import 'package:alorferi_app_practice/modeles/token_shareprefe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/url.dart';

class ProfileController extends GetxController {
  RxMap<String, dynamic> profile = <String, dynamic> {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final token =await TokenSharePrefences.loadToken();
      final url = Uri.parse("https://demo.alorferi.com/api/users/me");

      var response = await http.get(url, headers: {
        'Content-Type': 'Application/json',
        "Authorization": "Bearer $token",
      });


      if (response.statusCode == 200) {
        Map<String, dynamic> profileDecodeData = jsonDecode(response.body);

        var data = profileDecodeData['data'];
        profile.value = Map.from(data);

        print("Profile fetch successful");
      } else {
        print("Profile fetch unsuccessful");
      }
    } catch (e) {
      print("Error:=============> $e");
    }
  }
}
