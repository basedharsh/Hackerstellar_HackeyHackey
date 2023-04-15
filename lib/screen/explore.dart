import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spaceodyssey/screen/chatbot.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

const apiKey = "bbcf6842ec664349aa6a5288cd8b2db8";
const symbol = 'AAPL';
List<dynamic> _articles = [];

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  Future<List<dynamic>> fetchStockNews(String symbol, String apiKey) async {

    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=$symbol&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final articles = json['articles'];
      print(articles);
      return articles;

    } else {
      throw Exception('Failed to fetch news');
    }
  }


  @override
  void initState(){
    super.initState();
    fetchStockNews(symbol, apiKey).then((articles) {
      setState(() {
        _articles = articles;
      });
    }).catchError((error) {
      print('Error fetching news: $error');
    });
  }

  @override
  Widget build (BuildContext context){
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chatbotsupport(),
            ),
          );
        },
        child: Icon(Icons.chat_bubble),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: [
      SizedBox(height: 50),
      CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: _articles.map((article) {
          return GestureDetector(
            onTap: (){
              launchUrlString(article['url'] as String);
            },
            child: Container(
              height: mq.height * 0.2,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:article['urlToImage'] != null
                    ?  DecorationImage(
                  image:NetworkImage(article['urlToImage'] as String),
                  fit: BoxFit.cover,
                ):DecorationImage(
                  image:AssetImage('images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      article['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
          }).toList(),
      ),
        ],
      ),
    );
  }
}