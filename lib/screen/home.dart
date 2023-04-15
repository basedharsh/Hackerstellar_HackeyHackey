import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 56, horizontal: 20),
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(color: Colors.teal),
          child: Text(
            'Top Movers',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        Container(
          width: 300,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white),
          child: Text(
            'Search Stocks eg. Zomato , Kodak',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dhanuka',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '711.10',
                    style: TextStyle(
                        color: Color.fromARGB(255, 124, 233, 0), fontSize: 20),
                  ),
                  Text(
                    '(4.34%)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
