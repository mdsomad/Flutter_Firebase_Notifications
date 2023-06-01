
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
      
    
}






 
  
}