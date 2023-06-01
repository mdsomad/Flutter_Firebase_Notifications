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
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }



}