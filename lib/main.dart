import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';
import 'package:spaceodyssey/auths/loginauth.dart';
import 'package:spaceodyssey/screen/home.dart';
import 'package:spaceodyssey/screen/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spaceodyssey/screen/signuppage.dart';
import 'package:spaceodyssey/widgets/bottomnav.dart';
import 'auths/signupauth.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignupAuthorization(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginAuthorization(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Space Odyssey',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 255, 255, 255),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnp) {
            if (userSnp.hasData) {
              return Bottom();
              // and appbar

            }
            return SignUpPage();
          },
        ),
      ),
    );
  }
}




