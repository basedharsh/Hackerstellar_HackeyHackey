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
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/vid1.png'), fit: BoxFit.cover),
          // gradient: LinearGradient(
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Color.fromARGB(255, 19, 26, 71),
          //     Color.fromARGB(255, 19, 26, 71),
          //     Color.fromARGB(255, 129, 123, 119),
          //   ],
          // ),
        ),
        padding: EdgeInsets.all(80),
        child: Text(
          'What is Sustainable Investing?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
