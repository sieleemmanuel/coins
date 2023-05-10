import 'package:coins/net/firebase_methods.dart';
import 'package:coins/ui/home.dart';
import 'package:coins/ui/signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwrordVisisble = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, bottom: 40),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/coinsketch.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(
                height: 20,
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
                  obscureText: !_passwrordVisisble,
                  decoration: InputDecoration(
                      hintText: "Enter password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_passwrordVisisble
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwrordVisisble = !_passwrordVisisble;
                          });
                        },
                      ),
                      fillColor: Colors.indigo.shade50,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
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
                        setState(() {
                          _loading = true;
                        });
                        bool shouldNavigate = await login(
                            emailController.text, passwordController.text);
                        if (shouldNavigate) {
                          setState(() {
                            _loading = false;
                          });
                          if (!context.mounted) return;
                          if (_loading) {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const CircularProgressIndicator());
                          }

                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ),
                          );
                        }
                      }
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
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Signup();
                        }),
                      );
                    },
                    child: const Text(
                      "Signup",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
