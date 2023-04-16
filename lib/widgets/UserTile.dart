import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseFirestore.instance;

var userData;
var currentUser;
void getDataFromDatabase() async {
  currentUser = await FirebaseAuth.instance.currentUser;
  await db.collection("users").doc(currentUser.uid).get().then((event) {
    userData = event;
  });
}
class UserTile extends StatefulWidget {

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  void initState() {
    setState(() {
      getDataFromDatabase();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            tileColor: Colors.grey.shade300,
            textColor: Colors.teal,
            iconColor: Colors.teal,
            leading: Icon(Icons.person),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name'),
                Text((userData != null)
                    ? userData.data()["username"]
                    : "Loading..."),
                SizedBox(height: 4),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            tileColor: Colors.grey.shade300,
            textColor: Colors.teal,
            iconColor: Colors.teal,
            leading: Icon(Icons.person),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email'),
                Text((userData != null)
                    ? userData.data()["emailAddress"]
                    : "Loading..."),
                SizedBox(height: 4),
              ],
              // your second ListTile widget here
            ),
          ),
        )
      ],
    );
  }
}