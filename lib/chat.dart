import 'package:app1/ChatScreen.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: const Text(
            "Chat",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
