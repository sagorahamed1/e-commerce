// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
// import 'package:get/get.dart';
//
// import 'controller/log_in_controller.dart';
//
// class BaseService {
//   var loginController = Get.find<LogInController>();
//   final Dio dio = Dio();
//
//   BaseService() {
//     var token = loginController.token;
//     dio.options.headers['Authorization'] = 'Bearer $token';
//
//     // Provide the path to your certificate file
//     String certificatePath = 'path/to/your/certificate.crt';
//
//     (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//         (HttpClient client) {
//       client.badCertificateCallback =
//           (X509Certificate cert, String host, int port) {
//         // Read the certificate data from the file
//         String certificateData = File(certificatePath).readAsStringSync();
//
//         // Compare the server's certificate with the pinned certificate
//         return cert.pem == certificateData;
//       };
//     };
//   }
// }
