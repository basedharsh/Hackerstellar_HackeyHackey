import 'dart:ffi';

import 'package:flutter/material.dart';

class PortfolioTile extends StatefulWidget {
  // final String stockName;
  // final Double stockPrice;
  // final Double currentValue;
  // final Int stockQuantity;

  // PortfolioTile(
  //     {required this.stockName,
  //     required this.stockPrice,
  //     required this.currentValue,
  //     required this.stockQuantity});

  @override
  State<PortfolioTile> createState() => _PortfolioTileState();
}

class _PortfolioTileState extends State<PortfolioTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          height: 100,
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
                        'TataMoto',
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
                        color: Color.fromARGB(255, 124, 233, 0), fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Quatity:10',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 0.5,
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
