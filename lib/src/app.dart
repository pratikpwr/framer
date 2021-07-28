import 'package:flutter/material.dart';
import 'package:framer/src/utils/custom_theme.dart';
import 'package:framer/src/views/views.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLogIn = false;
    return MaterialApp(
      title: 'Framer',
      theme: myTheme(),
      debugShowCheckedModeBanner: false,
      home: isLogIn ? HomeScreen() : LogInScreen(),
    );
  }
}
