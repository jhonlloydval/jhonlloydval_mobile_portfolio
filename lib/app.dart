import 'package:flutter/material.dart';
import 'package:lloydportfolio/features/onboarding/splash_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

  
class _MyAppState extends State<MyApp>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return SplashPage();
  }
}



