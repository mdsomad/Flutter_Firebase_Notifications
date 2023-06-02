import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/notification_services.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NotificationService notificationServices = NotificationService();   //* <-- Create NotificationService class instance & object
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notificationServices.requestNotificationPermission();      //* <-- This Call function
    
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
   // notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value){

       print("Device Token This --> $value");
       
    });
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Notification"),
      ),

      body: Center(
        child: TextButton(onPressed: (){

          //* send notification from one device to another
          notificationServices.getDeviceToken().then((value)async{

            var data = {
              'to' : value.toString(),
              'priority': 'high',
              'notification' : {
                'title' : 'Somad' ,
                'body' : 'Learning Firebase Notification' ,
            },
              
            'data' : {
                'type' : 'msj' ,
                'id' : 'Somad1234'
              }

            };

            await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data) ,
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization' : 'key=AAAAp38j7B8:APA91bFvF0j8Ku7u5ELF8WFstukPOYj8rgc6tiJyks4GYnUMK2c06rRHgyTon6oWSbhfYzZv3-5Mq7DhUHYIRAwHji-NH5QDPtTkdYPMx_rJ-ok2rCACUCUuKB5T9bCzWS62t-cdc7Yp'
              }
            ).then((value){
              if (kDebugMode) {
                print(value.body.toString());
              }
            }).onError((error, stackTrace){
              if (kDebugMode) {
                print(error);
              }
            });



          });


        },
            child: Text('Send Notifications')),
      ),
  

      
      
    );
  }



}