import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  // final String title;
  // final String subtitle;
  // final String email;
  // final Icon  icon;

  // UserTile({required this.title,required this.subtitle, required this.email, required this.icon})

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.grey.shade300,
        textColor: Colors.teal,
        iconColor: Colors.teal,
        leading: Icon(Icons.person),
        subtitle: Text('Name'),
        title: Text('Harsh'),
      ),
    );
  }
}
