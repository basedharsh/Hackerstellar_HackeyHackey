import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spaceodyssey/screen/chatbot.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/NewsTile.dart';

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
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=$symbol&apiKey=$apiKey'));

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
  void initState() {
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
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 100,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chatbotsupport(),
              ),
            );
          },
          child: Icon(
            Icons.chat_bubble,
            size: 30,
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 19, 26, 71),
                  Color.fromARGB(255, 19, 26, 71),
                  Color.fromARGB(255, 129, 123, 119),
                ],
              )),
              // child: Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Image.asset(
              //     'images/space10.gif',
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Text(
                'Stock Market News',
                style: TextStyle(
                    color: Color.fromARGB(255, 40, 2, 2),
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              endIndent: 30,
              indent: 30,
            ),
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
                  onTap: () {
                    launchUrlString(article['url'] as String);
                  },
                  child: Container(
                    height: mq.height * 0.2,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: article['urlToImage'] != null
                          ? DecorationImage(
                              image:
                                  NetworkImage(article['urlToImage'] as String),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage('images/bg.jpg'),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
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
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                color: Color.fromARGB(255, 19, 26, 71),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Text(
                  'Trending Video Recommendations',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/vid1.png'), fit: BoxFit.cover),
                  // gradient: LinearGradient(
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     Color.fromARGB(255, 19, 26, 71),
                  //     Color.fromARGB(255, 19, 26, 71),
                  //     Color.fromARGB(255, 129, 123, 119),
                  //   ],
                  // ),
                ),
                padding: EdgeInsets.all(80),
                child: GestureDetector(
                  onTap: () {
                    const url1 = 'https://youtu.be/weVAN2HxXjk';
                    launchUrlString(url1 as String);
                  },
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/vid2.png'), fit: BoxFit.cover),
                  // gradient: LinearGradient(
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     Color.fromARGB(255, 19, 26, 71),
                  //     Color.fromARGB(255, 19, 26, 71),
                  //     Color.fromARGB(255, 129, 123, 119),
                  //   ],
                  // ),
                ),
                padding: EdgeInsets.all(80),
                child: GestureDetector(
                  onTap: () {
                    const url2 = 'https://youtu.be/GAKdQvkgM7U';
                    launchUrlString(url2 as String);
                  },
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/vid3.png'), fit: BoxFit.cover),
                  // gradient: LinearGradient(
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     Color.fromARGB(255, 19, 26, 71),
                  //     Color.fromARGB(255, 19, 26, 71),
                  //     Color.fromARGB(255, 129, 123, 119),
                  //   ],
                  // ),
                ),
                padding: EdgeInsets.all(80),
                child: GestureDetector(
                  onTap: () {
                    const url3 = 'https://youtu.be/AXVd54oe-hA';
                    launchUrlString(url3 as String);
                  },
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
