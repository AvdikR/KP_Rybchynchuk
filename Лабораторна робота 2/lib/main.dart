import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/presentation/StartPage/start_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        return MaterialApp(
          title: 'WhatUCread',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 163, 159, 169)),
          useMaterial3: true,
          ),  
        home: const StartPage(title: 'Start Page'),
        );
      }
    );
  }
}

