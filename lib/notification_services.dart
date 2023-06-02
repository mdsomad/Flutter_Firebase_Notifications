
import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
class NotificationService {

 FirebaseMessaging messaging = FirebaseMessaging.instance;
 final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  
void initLocalNotifications(BuildContext context, RemoteMessage message )async{

    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
       android: androidInitializationSettings,
       iOS: iosInitializationSettings
    ); 

    await _flutterLocalNotificationsPlugin.initialize(
       initializationSettings,
       onDidReceiveNotificationResponse: (payload) {
         
       },
       
    );
  
   
}
  
  


void firebaseInit(BuildContext context){

  FirebaseMessaging.onMessage.listen((message) { 
    if(kDebugMode){
       print(message.notification!.title.toString());
       print(message.notification!.body.toString());
    }
      if(Platform.isAndroid){
        initLocalNotifications(context, message);
        showNotification(message);
      }
  });
  
  
}




Future<void> showNotification(RemoteMessage message)async{

 AndroidNotificationChannel channel = AndroidNotificationChannel(
       Random.secure().nextInt(100000).toString(),
      "High importance Notification",
      importance: Importance.max
   );

  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    channel.id.toString() ,
    channel.name.toString(),
    // "Hello world",
    // "Nice Pick",
    channelDescription: "your channel description",
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
    sound: channel.sound
  );


    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true ,
      presentBadge: true ,
      presentSound: true
    ) ;

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails
    );
  
  
     Future.delayed(Duration.zero , (){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails ,
      );
    });
 

  

}






  // TODO Create requestNotificationPermission Function
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







// TODO Create getDeviceToken Function
Future<String> getDeviceToken()async{
   String? token = await messaging.getToken();
    return token!;
}

// TODO Create isTokenRefresh Function
void isTokenRefresh()async{
   messaging.onTokenRefresh.listen((event) {
    event.toString();
    print("Refresh");
   });
}

 
  
}