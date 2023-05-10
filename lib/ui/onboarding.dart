import 'package:coins/ui/login.dart';
import 'package:coins/ui/signup.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding();

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, bottom: 40),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            const Text(
              "WELCOME TO COINS",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30.0),
            Image.asset(
              "assets/coinsketch.png",
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){return Login();}));
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo[50],
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){return Signup();}));
                  },
                  child: const Text(
                    "SIGNUP",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
