import 'package:flutter/material.dart';
import 'package:framer/src/views/screens/home_screen.dart';
import 'package:framer/src/views/widgets/custom_button.dart';
import 'package:framer/src/views/widgets/logo_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: GoogleFonts.montserrat(fontSize: 12),
    )));
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppLogo(),
              Text(
                'Add frames to your Images!!!',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 12,
              ),
              Image.asset(
                'assets/login.png',
                height: _size.height * 0.35,
                width: _size.width,
              ),
              SizedBox(
                height: 26,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      style: GoogleFonts.openSans(fontSize: 14),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_rounded,
                          ),
                          hintText: 'Email',
                          hintStyle: GoogleFonts.openSans(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _passwordController,
                      style: GoogleFonts.openSans(fontSize: 14),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                          ),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.openSans(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 26,
              ),
              CustomButton('Sign In', () {
                if (_emailController.text.length == 0) {
                  showSnackBar('Please Enter Email.');
                } else if (_passwordController.text.length == 0) {
                  showSnackBar('Please Enter Password.');
                } else if (!_emailController.text.contains('@')) {
                  showSnackBar('Enter correct Email.');
                } else if (_passwordController.text.length < 6) {
                  showSnackBar('Password is too short.');
                } else {
                  _signIn(_emailController.text, _passwordController.text);
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(String email, String password) {
    if (email == 'admin@gmail.com' && password == 'admin123') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return HomeScreen();
      }));
    } else {
      showSnackBar('Please Enter correct email and password!');
    }
  }
}
