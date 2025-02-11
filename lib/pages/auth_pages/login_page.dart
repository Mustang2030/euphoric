// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/misc/validators.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Management App"),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/lo.jpg', scale: 1.5),
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 28),
                ),
                const SizedBox(height: 20),
                StyledFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  decoration: formS("Email", "", Icons.email),
                ),
                const SizedBox(height: 20),
                StyledFormField(
                  controller: _passwordController,
                  validator: validatePassword,
                  isPassword: true,
                  decoration: formS("Password", "", Icons.password),
                ),
                const SizedBox(height: 20),
                rslButton(context, "LOGIN", () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await signIn(context);
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message ?? "Unable to log in"),
                        ),
                      );
                    }
                  }
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.lightGreen),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteManagerProvider.splashScreen);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    User? user = userCredential.user;

    if (user != null) {
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection("Admins")
          .doc(user.email)
          .get();
      if (adminSnapshot.exists) {
        if (mounted) {
          Navigator.pushNamed(context, RouteManagerProvider.adminPanel);
        }
      } else {
        DocumentSnapshot patientSnapshot = await FirebaseFirestore.instance
            .collection("Patients")
            .doc(user.email)
            .get();
        if (patientSnapshot.exists) {
          Navigator.pushNamed(context, RouteManagerProvider.mainPage);
        } else {
          DocumentSnapshot doctorSnapshot = await FirebaseFirestore.instance
              .collection("Doctors")
              .doc(user.email)
              .get();
          if (doctorSnapshot.exists) {
            Navigator.pushNamed(context, RouteManagerProvider.doctorPanel);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("The user doesn't exist"),
              ),
            );
          }
        }
      }
    }
  }
}
