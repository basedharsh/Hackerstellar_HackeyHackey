import 'package:flutter/material.dart';

class Searchstock extends StatefulWidget {
  const Searchstock({super.key});

  @override
  State<Searchstock> createState() => _SearchstockState();
}

class _SearchstockState extends State<Searchstock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // search bar
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: Container(
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage("images/space10.gif"),
              //       fit: BoxFit.fitHeight),
              // ),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Stock Name"),
                    subtitle: Text("Stock Symbol"),
                    trailing: Text("Stock Price"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
