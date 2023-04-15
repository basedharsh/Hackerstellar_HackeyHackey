import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 20),
          child: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.w500),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: [
              Colors.purple,
              Color(0xff8c7ae6),
            ],
          ),
        ),
        height: 250,
        width: double.infinity,
      ),
    );
  }
}
