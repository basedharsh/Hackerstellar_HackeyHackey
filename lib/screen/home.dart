import 'package:flutter/material.dart';
import 'package:spaceodyssey/screen/portfolio.dart';
import 'package:spaceodyssey/screen/searchstock.dart';
import 'package:intl/intl.dart';
import 'package:spaceodyssey/screen/stats.dart';
import 'package:yahoofin/yahoofin.dart';

List<String> stockList = ["amzn", "googl", "aapl", "msft", "tsla"];

var yfin = YahooFin();
var stockInfo;
var stockInfoList = [];
var stockDetails;
var stockDetailsList = [];

void getStockDetails() async {
  stockDetailsList = await [];
  //stockInfo = await yfin.getStockInfo(ticker: "air");
  stockInfoList = List.generate(stockList.length, (index) {
    return yfin.getStockInfo(ticker: stockList[index]);
  });
  print("stockInfoList");
  print(stockInfoList);

  for (int i = 0; i < stockInfoList.length; i++) {
    await stockInfoList[i].getStockData().then((value) {
      stockDetailsList.add(value);
    });
  }
  print("stockDetailsList");
  print(stockDetailsList);

  // await stockInfo.getStockData().then(
  //         (value)  {
  //       stockDetails = value;
  //     }
  // );

  print(stockDetails.currentPrice);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    setState(() {
      getStockDetails();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/space.gif"), fit: BoxFit.fitWidth),
            ),
            height: 40,
            width: double.infinity,
          ),
          Container(
            // padding: EdgeInsets.only(top: 56, ),
            width: double.infinity,
            height: mq.height * 0.3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/space.gif"), fit: BoxFit.cover),
            ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Searchstock()),
                    );
                  },
                  child: Positioned(
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
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Trending Stocks',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
          Column(
              children: List.generate(
                  (stockDetailsList != null) ? stockDetailsList.length : 0,
                  (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Stat(stocksym: stockDetailsList[index].ticker),
                    ),
                  );
                },
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (stockDetailsList[index] != null)
                              ? stockDetailsList[index].metaData?.longName
                              : "----",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  (stockDetailsList[index] != null)
                                      ? stockDetailsList[index]
                                          .dayHigh
                                          .toString()
                                      : "----",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  (stockDetailsList[index] != null)
                                      ? stockDetailsList[index]
                                          .dayLow
                                          .toString()
                                      : "----",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ],
                            ),
                            Text(
                              (stockDetailsList[index] != null)
                                  ? stockDetailsList[index]
                                          .regularMarketChange
                                          .toStringAsFixed(3)
                                          .toString() +
                                      "%"
                                  : "----",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
        ],
      ),
    );
  }
}
