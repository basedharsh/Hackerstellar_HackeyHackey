import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spaceodyssey/screen/loginpage.dart';

class Stat extends StatefulWidget {
  const Stat({super.key});

  @override
  State<Stat> createState() => _StatState();
}

class _StatState extends State<Stat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: (){
            FirebaseAuth.instance.signOut().then((value) =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage())));
          },
          child: Text("LOGOUT"),
        ),
      ),
    );
  }
}
