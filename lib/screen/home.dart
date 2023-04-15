import 'package:flutter/material.dart';
import 'package:spaceodyssey/screen/portfolio.dart';
import 'package:spaceodyssey/screen/searchstock.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            color: Colors.teal,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Searchstock(),
                ),
              );
            },
            child: Container(
              // padding: EdgeInsets.only(top: 56, ),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Top Movers',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Positioned(
                    child: Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 193),
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Text(
                        'Search Stocks eg. Zomato , Kodak',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ],
              ),
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
                          color: Color.fromARGB(255, 124, 233, 0),
                          fontSize: 20),
                    ),
                    Text(
                      '(4.34%)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
