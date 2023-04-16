import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:spaceodyssey/screen/loginpage.dart';

import '../widgets/UserTile.dart';

final db = FirebaseFirestore.instance;

var userData;
var currentUser;

void getDataFromDatabase() async {
  currentUser = await FirebaseAuth.instance.currentUser;
  await db.collection("users").doc(currentUser.uid).get().then((event) {
    userData = event;
  });
}


class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  void initState() {
    setState(() {
      getDataFromDatabase();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
        child: Icon(
          Icons.logout,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (userData != null) ? userData.data()["username"] : "Loading...",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500),
                        ),
                        Text((userData != null && userData.data() != null && userData.data()["ESGcredits"] != null)
                            ? "ESGscore : " + userData.data()["ESGcredits"]
                            : ""),
                        Text((userData != null && userData.data() != null && userData.data()["currentCredit"] != null)
                            ? "TotalCredits : " + userData.data()["currentCredit"]
                            : "")

                      ],
                    ),
                    Image.asset(
                      'images/admin.gif',
                      height: 52,
                      color: Colors.white,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //           offset: const Offset(12, 26),
                    //           blurRadius: 50,
                    //           spreadRadius: 0,
                    //           color: Colors.grey.withOpacity(.25)),
                    //     ],
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: const CircleAvatar(
                    //     radius: 20,
                    //     backgroundColor: Colors.white,
                    //     child: Icon(
                    //       Icons.person,
                    //       size: 25,
                    //       color: Colors.teal,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Text(
                  'Stay up to date with your Stats',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            UserTile(),
            //name
            //Profit
          ],
        ),
      ),
    );
  }
}

// class _userState extends State<user> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.teal.shade300,
//         width: double.infinity,
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Profile',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 28,
//                     fontWeight: FontWeight.w500),
//               ),
// Container(
//   decoration: BoxDecoration(
//     boxShadow: [
//       BoxShadow(
//           offset: const Offset(12, 26),
//           blurRadius: 50,
//           spreadRadius: 0,
//           color: Colors.grey.withOpacity(.25)),
//     ],
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: const CircleAvatar(
//     radius: 25,
//     backgroundColor: Colors.white,
//     child: Icon(
//       Icons.person,
//       size: 25,
//       color: Colors.teal,
//     ),
//   ),
// )
//             ],
//           ),
// //         ),
//       ),
//     );
//   }
// }

// // class trialui extends StatefulWidget {
// //   const trialui({Key? key}) : super(key: key);

// //   @override
// //   State<trialui> createState() => _trialuiState();
// // }

// // class _trialuiState extends State<trialui> {
// //   int _selectedIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: const [
// //               TopBar(),
// //               PromoCard(),
// //               // Headline(),
// //               // CardListView(),
// //               // SHeadline(),
// //             ],
// //           ),
// //         ),
// //       ),
// //       // bottomNavigationBar: BottomAppBar(
// //       //   color: Colors.white,
// //       //   child: SizedBox(
// //       //     height: 56,
// //       //     width: MediaQuery.of(context).size.width,
// //       //     child: Padding(
// //       //       padding: const EdgeInsets.only(left: 25.0, right: 25.0),
// //       //       child: Row(
// //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       //         children: [
// //       //           IconBottomBar(
// //       //               text: "Home",
// //       //               icon: Icons.home,
// //       //               selected: _selectedIndex == 0,
// //       //               onPressed: () {
// //       //                 setState(() {
// //       //                   _selectedIndex = 0;
// //       //                 });
// //       //               }),
// //       //           IconBottomBar(
// //       //               text: "Restaurants",
// //       //               icon: Icons.restaurant,
// //       //               selected: _selectedIndex == 1,
// //       //               onPressed: () {
// //       //                 setState(() {
// //       //                   _selectedIndex = 1;
// //       //                 });
// //       //               }),
// //       //           IconBottomBar(
// //       //               text: "Map",
// //       //               icon: Icons.map,
// //       //               selected: _selectedIndex == 2,
// //       //               onPressed: () {
// //       //                 setState(() {
// //       //                   _selectedIndex = 2;
// //       //                 });
// //       //               }),
// //       //           IconBottomBar(
// //       //               text: "Profile",
// //       //               icon: Icons.person,
// //       //               selected: _selectedIndex == 3,
// //       //               onPressed: () {
// //       //                 setState(() {
// //       //                   _selectedIndex = 3;
// //       //                 });
// //       //               })
// //       //         ],
// //       //       ),
// //       //     ),
// //       //   ),
// //       // ),
// //     );
// //   }
// // }

// // class IconBottomBar extends StatelessWidget {
// //   IconBottomBar(
// //       {Key? key,
// //       required this.text,
// //       required this.icon,
// //       required this.selected,
// //       required this.onPressed})
// //       : super(key: key);
// //   final String text;
// //   final IconData icon;
// //   final bool selected;
// //   final Function() onPressed;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         IconButton(
// //           onPressed: (() {}),
// //           icon: Icon(
// //             icon,
// //             color: selected ? const Color(0xff15BE77) : Colors.grey,
// //           ),
// //         ),
// //         Text(
// //           text,
// //           style: TextStyle(
// //               fontSize: 14,
// //               height: .1,
// //               color: selected ? const Color(0xff15BE77) : Colors.grey),
// //         )
// //       ],
// //     );
// //   }
// // }

// // class TopBar extends StatelessWidget {
// //   const TopBar({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(25.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Profile",
// //             style: TextStyle(
// //                 color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
// //           ),
//           // Container(
//           //   decoration: BoxDecoration(
//           //     boxShadow: [
//           //       BoxShadow(
//           //           offset: const Offset(12, 26),
//           //           blurRadius: 50,
//           //           spreadRadius: 0,
//           //           color: Colors.grey.withOpacity(.25)),
//           //     ],
//           //     borderRadius: BorderRadius.circular(20),
//           //   ),
//           //   child: const CircleAvatar(
//           //     radius: 25,
//           //     backgroundColor: Colors.white,
//           //     child: Icon(
//           //       Icons.person,
//           //       size: 25,
//           //       color: Colors.teal,
//           //     ),
//           //   ),
//           // )
//     //     ],
//     //   ),
//     // );
// //   }
// // }

// // // class SearchInput extends StatelessWidget {
// // //   const SearchInput({Key? key}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return
// // //   }
// // // }

// // class PromoCard extends StatelessWidget {
// //   const PromoCard({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(25.0),
// //           child: Container(
// //             color: Colors.grey.withOpacity(.25),
// //             child: Image.network(
// //               'https://thumbs.dreamstime.com/z/here-original-background-design-originally-designed-as-credit-card-add-your-own-information-template-generic-125619243.jpg',
// //               fit: BoxFit.cover,
// //             ),
// //             width: MediaQuery.of(context).size.width,
// //             height: 150,
// //             // decoration: BoxDecoration(
// //             //   borderRadius: BorderRadius.circular(15),
// //             //   gradient: const LinearGradient(
// //             //     colors: [
// //             //       Color(0xff53E88B),
// //             //       Color(0xff15BE77),
// //             //     ],
// //             //   ),
// //             // ),
// //             // child: Stack(
// //             //   children: [
// //             //     Opacity(
// //             //       opacity: .5,
// //             //       child: Image.network(
// //             //           "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/BACKGROUND%202.png?alt=media&token=0d003860-ba2f-4782-a5ee-5d5684cdc244",
// //             //           fit: BoxFit.cover),
// //             //     ),
// //             //     Image.network(
// //             //         "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Image.png?alt=media&token=8256c357-cf86-4f76-8c4d-4322d1ebc06c"),
// //             //     const Align(
// //             //       alignment: Alignment.topRight,
// //             //       child: Padding(
// //             //         padding: EdgeInsets.all(25.0),
// //             //         child: Text(
// //             //           "Want some\nicecream?",
// //             //           style: TextStyle(
// //             //               color: Colors.white,
// //             //               fontSize: 22,
// //             //               fontWeight: FontWeight.bold),
// //             //         ),
// //             //       ),
// //             //     ),
// //             //   ],
// //             // ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// // // }

// // // class Headline extends StatelessWidget {
// // //   const Headline({Key? key}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: EdgeInsets.only(left: 25.0, right: 25.0),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: [
// // //           Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: const [
// // //               Text(
// // //                 "Nearest Restaurants",
// // //                 style: TextStyle(
// // //                     color: Colors.black,
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.normal),
// // //               ),
// // //               Text(
// // //                 "The best food close to you",
// // //                 style: TextStyle(
// // //                     color: Colors.grey,
// // //                     fontSize: 12,
// // //                     fontWeight: FontWeight.normal),
// // //               ),
// // //             ],
// // //           ),
// // //           const Text(
// // //             "View More",
// // //             style: TextStyle(
// // //                 color: Color(0xff15BE77), fontWeight: FontWeight.normal),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class SHeadline extends StatelessWidget {
// // //   const SHeadline({Key? key}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: EdgeInsets.only(left: 25.0, right: 25.0),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: [
// // //           Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(
// // //                 "Popular Menu",
// // //                 style: TextStyle(
// // //                     color: Colors.black,
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.normal),
// // //               ),
// // //               Text(
// // //                 "The best food for you",
// // //                 style: TextStyle(
// // //                     color: Colors.grey,
// // //                     fontSize: 12,
// // //                     fontWeight: FontWeight.normal),
// // //               ),
// // //             ],
// // //           ),
// // //           Text(
// // //             "View More",
// // //             style: TextStyle(
// // //                 color: Color(0xff15BE77), fontWeight: FontWeight.normal),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class CardListView extends StatelessWidget {
// // //   const CardListView({Key? key}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(top: 25.0, right: 25.0, bottom: 15.0),
// // //       child: SizedBox(
// // //         width: MediaQuery.of(context).size.width,
// // //         height: 175,
// // //         child: ListView(
// // //           scrollDirection: Axis.horizontal,
// // //           children: [
// // //             Card(
// // //                 "Vegan",
// // //                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Resturant%20Image%20(1).png?alt=media&token=461162b1-686b-4b0e-a3ee-fae1cb8b5b33",
// // //                 "8 min away"),
// // //             Card(
// // //                 "Italian ",
// // //                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Restaurant%20Image.png?alt=media&token=43509b4c-269e-4279-8c88-36dc9ed27a66",
// // //                 "12 min away"),
// // //             Card(
// // //                 "Vegan",
// // //                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Resturant%20Image%20(1).png?alt=media&token=461162b1-686b-4b0e-a3ee-fae1cb8b5b33",
// // //                 "15 min away"),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Card extends StatelessWidget {
// // //   final String text;
// // //   final String imageUrl;
// // //   final String subtitle;

// // //   Card(this.text, this.imageUrl, this.subtitle, {Key? key}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(left: 25.0, bottom: 15),
// // //       child: Container(
// // //         width: 150,
// // //         height: 150,
// // //         padding: const EdgeInsets.all(15.0),
// // //         decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.circular(12.5),
// // //           boxShadow: [
// // //             BoxShadow(
// // //                 offset: const Offset(10, 20),
// // //                 blurRadius: 10,
// // //                 spreadRadius: 0,
// // //                 color: Colors.grey.withOpacity(.05)),
// // //           ],
// // //         ),
// // //         child: Column(
// // //           children: [
// // //             Image.network(imageUrl, height: 70, fit: BoxFit.cover),
// // //             Spacer(),
// // //             Text(text,
// // //                 textAlign: TextAlign.center,
// // //                 style: TextStyle(
// // //                   color: Colors.black,
// // //                   fontWeight: FontWeight.bold,
// // //                   fontSize: 18,
// // //                 )),
// // //             SizedBox(
// // //               height: 5,
// // //             ),
// // //             Text(
// // //               subtitle,
// // //               textAlign: TextAlign.center,
// // //               style: TextStyle(
// // //                   color: Colors.grey,
// // //                   fontWeight: FontWeight.normal,
// // //                   fontSize: 12),
// // //             ),
// // //             SizedBox(
// // //               height: 10,
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // }
