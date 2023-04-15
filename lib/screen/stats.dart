import 'package:flutter/material.dart';
import 'package:yahoofin/yahoofin.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

var yfin = YahooFin();
String stockSymbol = "";
var graphData;
var _chartData;

var stockInfo;
var stockDetails;

void getGraphData() async {
  stockInfo = await yfin.getStockInfo(ticker: stockSymbol);
  await stockInfo.getStockData().then((value) {
    stockDetails = value;
  });
  //print(stockDetails.regularMarketChangePercent);

  StockHistory hist = await yfin.initStockHistory(ticker: stockSymbol);
  graphData = await hist.getChartQuotes(
      interval: StockInterval.oneDay, period: StockRange.oneMonth);
  //print(graphData.chartQuotes.high);

  _chartData = List.generate(graphData.chartQuotes?.timestamp.length, (index) {
    return ChartSampleData(
        x: DateTime(
            int.parse(DateTime.fromMicrosecondsSinceEpoch(
                    graphData.chartQuotes.timestamp[index].toInt() * 1000000,
                    isUtc: true)
                .toString()
                .split(" ")[0]
                .toString()
                .split("-")[0]),
            int.parse(DateTime.fromMicrosecondsSinceEpoch(
                    graphData.chartQuotes.timestamp[index].toInt() * 1000000,
                    isUtc: true)
                .toString()
                .split(" ")[0]
                .toString()
                .split("-")[1]),
            int.parse(DateTime.fromMicrosecondsSinceEpoch(
                    graphData.chartQuotes.timestamp[index].toInt() * 1000000,
                    isUtc: true)
                .toString()
                .split(" ")[0]
                .toString()
                .split("-")[2])),
        open: graphData.chartQuotes?.open[index],
        high: graphData.chartQuotes?.high[index],
        low: graphData.chartQuotes?.low[index],
        close: graphData.chartQuotes?.close[index]);
  });

  print(_chartData);
}

class Stat extends StatefulWidget {
  String stocksym;

  Stat({required this.stocksym}) {
    stockSymbol = this.stocksym;
  }

  @override
  State<Stat> createState() => _StatState();
}

class _StatState extends State<Stat> {
  //late List<ChartSampleData> _chartData;
  late TrackballBehavior _trackballBehavior;
  RefreshController _statsRefresh = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    print(stockSymbol);

    setState(() {
      getGraphData();
    });

    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SmartRefresher(
      controller: _statsRefresh,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1000));
        setState(() {
          getGraphData();
        });
        _statsRefresh.refreshCompleted();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.teal.shade400,
                ),
                child: Center(
                  child: Text(
                    stockSymbol,
                    style: TextStyle(
                        fontSize: 27,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SfCartesianChart(
                backgroundColor: Colors.black,
                title: ChartTitle(
                  text: 'Graph',
                  textStyle: TextStyle(color: Colors.white),
                ),
                legend: Legend(isVisible: true),
                trackballBehavior: _trackballBehavior,
                series: <CandleSeries>[
                  CandleSeries<ChartSampleData, DateTime>(
                      dataSource: _chartData,
                      name: 'AAPL',
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      lowValueMapper: (ChartSampleData sales, _) => sales.low,
                      highValueMapper: (ChartSampleData sales, _) => sales.high,
                      openValueMapper: (ChartSampleData sales, _) => sales.open,
                      closeValueMapper: (ChartSampleData sales, _) =>
                          sales.close)
                ],
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat.MMM(),
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                    minimum: 75,
                    maximum: 300,
                    interval: 20,
                    numberFormat:
                        NumberFormat.simpleCurrency(decimalDigits: 0)),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(color: Colors.black),
                child: Text(
                  'Stock States',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Regular Market Change Percent : " +
                          stockDetails.regularMarketChangePercent.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Regular Market Change : " +
                          stockDetails.regularMarketChange.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Current Price : " +
                          stockDetails.currentPrice.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Day High : " + stockDetails.dayHigh.toString()
                      : "",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Day Low : " + stockDetails.dayLow.toString()
                      : "",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Ticker : " + stockDetails.ticker.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Regular Market Volume : " +
                          stockDetails.regularMarketVolume.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Average Analyst Rating : " +
                          stockDetails.metaData.averageAnalystRating.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Currency : " +
                          stockDetails.metaData.currency.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  (stockDetails != null)
                      ? "Exchange : " +
                          stockDetails.metaData.exchange.toString()
                      : "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high,
  });

  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
}
