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
        decoration: BoxDecoration(
            gradient: LinearGradient(
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 19, 26, 71),
            Color.fromARGB(255, 19, 26, 71),
            Color.fromARGB(255, 129, 123, 119),
          ],
        )),
        padding: EdgeInsets.all(40),
        child: Text(
          'Hello',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 19),
        ),
      ),
    );
  }
}
