import 'package:coins/net/firebase_methods.dart';
import 'package:coins/ui/login.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _condfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, bottom: 40),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const Text(
                "SIGNUP",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/coinsketch.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter Email Address",
                    prefixIcon: const Icon(Icons.email_rounded),
                    fillColor: Colors.indigo.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    fillColor: Colors.indigo.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !_condfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    prefixIcon: const Icon(Icons.lock),
                    fillColor: Colors.indigo.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_condfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _condfirmPasswordVisible = !_condfirmPasswordVisible;
                        });
                      },
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
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40)),
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        bool shouldNavigate = await signUp(
                            emailController.text, passwordController.text);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${emailController.text}: ${passwordController.text}: $shouldNavigate"),
                          ),
                        );
                        if (shouldNavigate) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ),
                          );
                        } else {
                          print("Failed");
                        }
                      }
                    },
                    child: const Text(
                      "SIGNUP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
