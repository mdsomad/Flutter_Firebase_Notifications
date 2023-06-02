import 'package:flutter/material.dart';



class MessageScreen extends StatefulWidget {
  final String id;
 MessageScreen({super.key, required this.id});

  @override
  State<MessageScreen> createState() => _MessageStateScreen();
}

class _MessageStateScreen extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Screen' +widget.id),
      ),
    );
  }
}