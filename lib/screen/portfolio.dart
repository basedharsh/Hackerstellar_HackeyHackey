import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 56, horizontal: 20),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(color: Colors.teal),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Portfolio',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Spacer(),
                  //add icon
                  Icon(
                    Icons.show_chart,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.blue,
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Buy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 4.5,
                          ),
                          Text(
                            'TataMotors',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text('Tata Motors'),
                      Text(
                        'Bought Price : 469.5',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '711.10',
                        style: TextStyle(
                            color: Color.fromARGB(255, 124, 233, 0),
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '(4.34%)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
