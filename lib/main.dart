import 'package:chat_app1/screens/auth_screen.dart';
import 'package:chat_app1/screens/chat_screen.dart';
import 'package:chat_app1/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        canvasColor: Color(0xFF263859),
        primarySwatch: Colors.amber,
        // primaryColor: Color(0xFFbbe1fa),
        backgroundColor: Color(0xFF263859),
        accentColor: Color(0xFF00818a),
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Color(0xFF263859),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return SplashScreen();
          }
          if (snapshot.hasData) {
            return ChatScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
