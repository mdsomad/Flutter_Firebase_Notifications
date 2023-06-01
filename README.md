# Flutter Firebase Notifications

A new Flutter project.

## Getting Started


- First Add this package --> app_settings: ^4.2.0
```sh
  flutter pub add app_settings
```



- 1: TODO Create Class NotificationService Codes

```sh

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationService {

 FirebaseMessaging messaging = FirebaseMessaging.instance;

  
  requestNotificationPermission()async{

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

  
      if(settings.authorizationStatus == AuthorizationStatus.authorized){

           if(kDebugMode){
             print("uers granted permission");
           }

      }else if(settings.authorizationStatus == AuthorizationStatus.provisional){

           if(kDebugMode){
              print("uers granted provisionl permission");
            }

      }else{

          AppSettings.openNotificationSettings();

          if(kDebugMode){
             print("uers denied permission");
          }

      }







// Add New Code
Future<String> getDeviceToken()async{
   String? token = await messaging.getToken();
    return token!;
}


void isTokenRefresh()async{
   messaging.onTokenRefresh.listen((event) {
    event.toString();
    print("Refresh");
   });
}



      
    
}






 
  
}


```



- 2 : HomePage Codes 

```sh
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/notification_services.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NotificationService notificationService = NotificationService();   //* <-- Create NotificationService class instance & object
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notificationService.requestNotificationPermission(); //* <-- This Call function

    // Call new Function
    notificationService.isTokenRefresh();
    
    notificationService.getDeviceToken().then((value){

       print("Device Token This --> $value");
       
    });
    
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }





}


```
