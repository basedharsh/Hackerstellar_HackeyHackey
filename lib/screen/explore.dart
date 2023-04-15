import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
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
            items: [
              // height of slider is 200

              //1st Image of Slider
              Container(
                height: mq.height * 0.2,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("images/carousel1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //2nd Image of Slider
              Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("images/carousel2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //3rd Image of Slider
              Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("images/carousel3.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // //4th Image of Slider
              Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("images/carousel4.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
