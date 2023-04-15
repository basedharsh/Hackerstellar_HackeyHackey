import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:spaceodyssey/screen/home.dart';
import 'package:spaceodyssey/screen/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space Odyssey',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: LoginPage(),
    );
  }
}

//liquid swipe
// class Main1 extends StatelessWidget {
//    Main1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LiquidSwipe(
//         // Pass the pages to the LiquidSwipe widget here
//         pages: pages,
//         enableLoop: true, // Enable looping of the pages
//         fullTransitionValue: 300,
//         enableSideReveal: true,
//         // Slide icon widget to show on the right side of the screen
//         slideIconWidget: const Icon(
//           Icons.arrow_back_ios,
//           size: 45,
//         ),
//         positionSlideIcon: 0.5, // Position of the slide icon
//         waveType: WaveType.liquidReveal,
//       ),
//     );
//   }

//   // Initialize the pages first and then pass it to the LiquidSwipe widget
//   final pages = [
//     Container(
//       width: double
//           .infinity, // Set the width of the container to the width of the screen
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 25),
//             child: Image.asset(
//               'images/test3.jpg',
//               height: 300,
//               width: 300,
//             ),
//           ),

//           // This padding is used to give some space between the image and the text
//           const Padding(
//             padding: EdgeInsets.only(top: 10, bottom: 20),
//             child: Text(
//               'Welcome to WFC !',
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.grey,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),

//     // Second page
//     Container(
//       width: double
//           .infinity, // Set the width of the container to the width of the screen
//       color: Colors.yellow,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 25),
//             child: Image.asset(
//               'images/test2.jpg',
//               height: 300,
//               width: 300,
//             ),
//           ),

//           // This padding is used to give some space between the image and the text
//           const Padding(
//             padding: EdgeInsets.only(top: 10, bottom: 20),
//             child: Text(
//               'Feed the hungry',
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),

// // This is the third page
//     Container(
//       width: double
//           .infinity, // Set the width of the container to the width of the screen
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 25),
//             child: Image.asset(
//               'images/test1.jpg',
//               height: 300,
//               width: 300,
//             ),
//           ),

//           // This padding is used to give some space between the image and the text
//           const Padding(
//             padding: EdgeInsets.only(top: 10, bottom: 20),
//             child: Text(
//               'We are here to help',
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.grey,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           // This is the button
//           Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Home()),
//                 );
//               },
//               child: const Text(
//                 'Get Started',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: Color.fromARGB(255, 123, 175, 216),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ];
// }
