import 'package:flutter/material.dart';

class NewsTile extends StatefulWidget {
  const NewsTile({super.key});

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        color: Colors.orange,
        padding: EdgeInsets.all(40),
        child: Text(
          'Hello',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
