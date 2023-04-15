import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              children: [
                Text(
                  'Portfolio',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                const Spacer(),
                //add icon
                Icon(
                  Icons.show_chart,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
