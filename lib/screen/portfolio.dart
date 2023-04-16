import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spaceodyssey/widgets/PortfolioTile.dart';

final db = FirebaseFirestore.instance;
var userOrderDetails;
var currentUser;

void userOrderDetailsDatabase()async{
  await db.collection("stockOrder").get().then((event) {
    userOrderDetails = event.docs;
  });
}

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  void initState(){

    setState(() {
      userOrderDetailsDatabase();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              // PortfolioTile(),
              // PortfolioTile(),
              // PortfolioTile(),
              // PortfolioTile(),
              // PortfolioTile(),
              // PortfolioTile(),
              // PortfolioTile(),
              // PortfolioTile(),
              // PortfolioTile(),
              Column(
                children: List.generate((userOrderDetails!=null)?userOrderDetails.length:0, (index) {
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
                                      userOrderDetails[index].data()["ticker"],
                                      style: TextStyle(
                                          fontSize: 19, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Bought Price : '+userOrderDetails[index].data()["currentprice"],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text("ESG Score : "+userOrderDetails[index].data()["ESGscore"])
                              ],
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  userOrderDetails[index].data()["dayhigh"],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 233, 0), fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quatity:'+userOrderDetails[index].data()["ammount"],
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
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
