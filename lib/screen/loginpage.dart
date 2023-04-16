import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:spaceodyssey/screen/signuppage.dart';
import 'package:spaceodyssey/widgets/bottomnav.dart';

import '../auths/loginauth.dart';

TextEditingController emailAddress = TextEditingController();
TextEditingController password = TextEditingController();

bool changeButton = false;

// Now login page using Rive animation

// Main Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  //on screen tap keyboard will be closed funxtion
  void _requestKeyboardClose() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    LoginAuthorization loginAuth = Provider.of<LoginAuthorization>(context);
    // MediaQuery for responsive design
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 53, 53),
      body: SafeArea(
        //on screen tap keyboard will be closed
        child: GestureDetector(
          onTap: () {
            _requestKeyboardClose();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "Terra-Invest",
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 245, 241, 241),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome to Tera-Invest",
                  style: GoogleFonts.autourOne(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 242, 234, 255),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                // artboard for animation here
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 0.3 * size.height,
                  //write width using MediaQuery
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 0.6 * size.width,
                  child: RiveAnimation.asset(
                    "images/login.riv",
                    // height of animation
                    fit: BoxFit.fill,

                    //ROund corners of animation
                    alignment: Alignment.topCenter,
                    stateMachines: const ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                          artboard, "Login Machine");
                      if (controller == null) return;

                      artboard.addController(controller!);
                      isChecking = controller?.findInput("isChecking");
                      isHandsUp = controller?.findInput("isHandsUp");
                      trigSuccess = controller?.findInput("trigSuccess");
                      trigFail = controller?.findInput("trigFail");
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  // padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: 0.96 * size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 190, 190, 199),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      SizedBox(height: 30),
                      //For Email
                      TextFormField(
                        controller: emailAddress,
                        onChanged: ((value) {
                          if (isHandsUp != null) {
                            isHandsUp!.change(false);
                          }
                          if (isChecking == null) return;

                          isChecking!.change(true);
                        }),
                        decoration: InputDecoration(
                          //label text and style
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black87,
                          ),
                          // Icon for email
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),

                          hintText: 'Email',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                            //thickness: 5,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // For Password
                      TextFormField(
                        onChanged: ((value) {
                          if (isChecking != null) {
                            isChecking!.change(false);
                          }
                          if (isHandsUp == null) return;

                          isHandsUp!.change(true);
                        }),
                        controller: password,
                        obscureText: true,
                        //Password decoration
                        decoration: InputDecoration(
                          //label text and style
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.black87,
                          ),
                          // Icon for email
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),

                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                            //thickness: 5,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      (loginAuth.loading == false)
                          ? MaterialButton(
                              onPressed: () {
                                //Login button on pressed validation
                                loginAuth.loginValidation(
                                    emailAddress: emailAddress,
                                    password: password,
                                    context: context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              color: Color.fromARGB(255, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(height: 10),
                      Divider(
                        color: Color.fromARGB(255, 82, 80, 80),
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15,
                              // align the text to the left instead of centered
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ),
                                );
                              },
                              child: Text(' Signup',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 93, 0, 255),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Text("Forgot Password?",
                      //     style: TextStyle(
                      //         color: Color.fromARGB(255, 210, 152, 255),
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.bold)),
                      // SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
