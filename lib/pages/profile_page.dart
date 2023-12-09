import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/url.dart';
import '../controller/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {

    final profileData = profileController.profile;

    return Scaffold(

      appBar: AppBar(
        title: Text('My Profile'),
      ),


      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                NetworkImage("${Urls.baseUrl}${profileData["url"]}"),
              ),


              Column(
                children: [
                  Text("${profileData['name']}",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500),),
                  Text("${profileData["email"]}"),
                ],
              ),


            ],
          ),



          ListTile(
            title: Text("My Orders",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            subtitle: Text("All ready have 12 orders"),
          ),

          ListTile(
            title: Text("Shopping addresses",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
            subtitle: Text("4 Addresses"),
          ),


          ListTile(
            title: Text("Pyment Method",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
            subtitle: Text("Bkash, Nagad"),
          ),


          ListTile(
            title: Text("My Reviews",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
            subtitle: Text("Reviews for 6 items"),
          ),


          ListTile(
            title: Text("Setting",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
            subtitle: Text("Notifications, password"),
          )
        ],
      )
    );
  }
}
