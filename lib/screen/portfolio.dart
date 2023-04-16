import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spaceodyssey/widgets/PortfolioTile.dart';
import 'package:yahoofin/yahoofin.dart';

final db = FirebaseFirestore.instance;
var yfin = YahooFin();
var stockInfo;
var stockDetails;
var userData;
var currentUser;
var userOrderDetails;

void userOrderDetailsDatabase() async {
  await db.collection("stockOrder").get().then((event) {
    userOrderDetails = event.docs;
    print(userOrderDetails);
  });

  currentUser = await FirebaseAuth.instance.currentUser;
  await db.collection("users").doc(currentUser.uid).get().then((event) {
    userData = event;
  });
}

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  void initState() {
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 56, horizontal: 20),
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/port.gif"),
                      fit: BoxFit.fitWidth),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // Text(
                    //   'Portfolio',
                    //   style: TextStyle(fontSize: 25, color: Colors.white),
                    // ),
                    Spacer(),
                    //add icon
                    // Icon(
                    //   Icons.show_chart,
                    //   color: Colors.white,
                    // ),
                  ],
                ),
              ),
              Column(
                children: List.generate(
                    (userOrderDetails != null) ? userOrderDetails.length : 0,
                    (index) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Card(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        elevation: 5,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // Container(
                                      //   color: Colors.blue,
                                      //   padding: EdgeInsets.all(5),
                                      //   child: Text(
                                      //     'Buy',
                                      //     style: TextStyle(color: Colors.white),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: 4.5,
                                      ),
                                      Text(
                                        (userOrderDetails != null)
                                            ? userOrderDetails[index]
                                                .data()["ticker"]
                                            : "",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Bought Price : ' +
                                        userOrderDetails[index]
                                            .data()["currentprice"],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      stockInfo = await yfin.getStockInfo(
                                          ticker: userOrderDetails[index]
                                              .data()["ticker"]);
                                      await stockInfo
                                          .getStockData()
                                          .then((value) {
                                        stockDetails = value;
                                      });

                                      var buyprice = userOrderDetails[index]
                                          .data()["currentprice"];
                                      var currprice = stockDetails.currentPrice;

                                      await db
                                          .collection("users")
                                          .doc(currentUser.uid)
                                          .update({
                                        "currentCredit": (int.parse(userData
                                                    .data()["currentCredit"]
                                                    .replaceAll(
                                                        RegExp(r'[^0-9]'),
                                                        '')) +
                                                stockDetails.currentPrice *
                                                    int.parse(
                                                        userOrderDetails[index]
                                                            .data()["ammount"]))
                                            .toString()
                                      }).onError((e, _) => print(
                                              "Error In Updating Order: $e"));

                                      await db
                                          .collection("stockOrder")
                                          .doc(userOrderDetails[index].id)
                                          .delete();

                                      var prolos =
                                          int.parse(buyprice) - currprice;

                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(SnackBar(
                                      //     content: Text(
                                      //         (int.parse(buyprice) - currprice).toString()
                                      //     )));
                                      print(prolos);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      color: Colors.blue,
                                      padding: EdgeInsets.all(5),
                                      child: Center(
                                        child: Text(
                                          'Sell',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //Text("ESG Score : "+userOrderDetails[index].data()["ESGscore"])
                                ],
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    userOrderDetails[index].data()["dayhigh"],
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 124, 233, 0),
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Quatity:' +
                                        userOrderDetails[index]
                                            .data()["ammount"],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
