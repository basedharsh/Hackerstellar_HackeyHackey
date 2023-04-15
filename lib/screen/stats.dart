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

void getGraphData()async{
  stockInfo = await yfin.getStockInfo(ticker: stockSymbol);
  await stockInfo.getStockData().then(
          (value)  {
        stockDetails = value;
      }
  );
  //print(stockDetails.regularMarketChangePercent);

  StockHistory hist = await yfin.initStockHistory(ticker: stockSymbol);
  graphData = await hist.getChartQuotes(interval: StockInterval.oneDay,period: StockRange.oneMonth);
  //print(graphData.chartQuotes.high);

  _chartData = List.generate(
      graphData.chartQuotes?.timestamp.length, (index) {
    return ChartSampleData(
        x: DateTime(
            int.parse(DateTime.fromMicrosecondsSinceEpoch(graphData.chartQuotes.timestamp[index].toInt()*1000000,isUtc: true).toString().split(" ")[0].toString().split("-")[0]),
            int.parse(DateTime.fromMicrosecondsSinceEpoch(graphData.chartQuotes.timestamp[index].toInt()*1000000,isUtc: true).toString().split(" ")[0].toString().split("-")[1]),
            int.parse(DateTime.fromMicrosecondsSinceEpoch(graphData.chartQuotes.timestamp[index].toInt()*1000000,isUtc: true).toString().split(" ")[0].toString().split("-")[2])
        ),
        open: graphData.chartQuotes?.open[index],
        high: graphData.chartQuotes?.high[index],
        low: graphData.chartQuotes?.low[index],
        close: graphData.chartQuotes?.close[index]
    );
  }
  );

  print(_chartData);

}

class Stat extends StatefulWidget {
  String stocksym;

  Stat({required this.stocksym}){
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
  void initState(){
    super.initState();
    print(stockSymbol);

    setState(() {
      getGraphData();
    });

    _trackballBehavior = TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _statsRefresh,
        onRefresh: ()async{
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
                Center(
                  child: Text(stockSymbol),
                ),

                SfCartesianChart(
                  backgroundColor: Colors.black87,
                  title: ChartTitle(text: 'Graph Name'),
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
                        closeValueMapper: (ChartSampleData sales, _) => sales.close)
                  ],
                  primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat.MMM(),
                      majorGridLines: MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                      minimum: 75,
                      maximum: 300,
                      interval: 20,
                      numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
                ),
                Text((stockDetails!=null)?"regularMarketChangePercent : "+stockDetails.regularMarketChangePercent.toString():""),
                Text((stockDetails!=null)?"regularMarketChange : "+stockDetails.regularMarketChange.toString():""),
                Text((stockDetails!=null)?"currentPrice : "+stockDetails.currentPrice.toString():""),
                Text((stockDetails!=null)?"dayHigh : "+stockDetails.dayHigh.toString():""),
                Text((stockDetails!=null)?"dayLow : "+stockDetails.dayLow.toString():""),
                Text((stockDetails!=null)?"ticker : "+stockDetails.ticker.toString():""),
                Text((stockDetails!=null)?"regularMarketVolume : "+stockDetails.regularMarketVolume.toString():""),
                Text((stockDetails!=null)?"averageAnalystRating : "+stockDetails.metaData.averageAnalystRating.toString():""),
                Text((stockDetails!=null)?"currency : "+stockDetails.metaData.currency.toString():""),
                Text((stockDetails!=null)?"exchange : "+stockDetails.metaData.exchange.toString():""),
              ],
            ),
          ),
        ),
      )
    );
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