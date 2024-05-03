import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/firebase_options.dart';
import 'package:what_u_cread/models/currentUser.dart';
import 'package:what_u_cread/presentation/LoginScreen/root/root.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:dcdg/dcdg.dart';

/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MainApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder:(context, orientation, deviceType) {
        return ChangeNotifierProvider(
          create: (context) => CurrentUser(),
          child: MaterialApp(
            title: 'WhatUCread', // назва застосунку
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 165, 180, 185)),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
              displayColor: Colors.blueGrey[600],
              ),
            ),  
            //home: WelcomeScreen(),
            home: Root(), // Початкове вікно
          )
        );
      },
    );
  }
}

