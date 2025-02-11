import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/misc/validators.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // currently logged in patient
  final currentUser = FirebaseAuth.instance.currentUser;
  // all the patients
  final allUsers = FirebaseFirestore.instance.collection("Patients");

  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.person,
                    size: 140,
                  ),
                  Text(
                    "${currentUser!.displayName}",
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      "Please leave a review! Thank you!",
                    ),
                  ),
                  const SizedBox(height: 20),
                  StyledFormField(
                    controller: _emailController,
                    validator: validateEmail,
                    decoration:
                        formS("Enter your Email", "", Icons.abc_outlined),
                  ),
                  const SizedBox(height: 20),
                  StyledFormField(
                    controller: _hospitalController,
                    validator: validateCap,
                    decoration: formS("Hospital Name", "", Icons.abc_outlined),
                  ),
                  const SizedBox(height: 20),
                  StyledFormField(
                    controller: _reviewController,
                    validator: validateCap,
                    decoration: formS("Review", "", Icons.abc_outlined),
                  ),
                  const SizedBox(height: 20),
                  rslButton(context, "Submit", () {
                    if (_formKey.currentState!.validate()) {
                      User? userCredential = FirebaseAuth.instance.currentUser;

                      FirebaseFirestore.instance
                          .collection("Reviews")
                          .doc(userCredential?.email)
                          .set(
                        {
                          "Hospital Name": _hospitalController.text,
                          "Review": _reviewController.text,
                          "Email": _emailController.text
                        },
                      );

                      log("Review sent to admin.");

                      // Show a confirmation message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '${currentUser?.displayName} your review is received!')),
                      );

                      // Clear the form
                      _emailController.clear();
                      _reviewController.clear();
                      _hospitalController.clear();
                    }
                  })
                ],
              ),
              rslButton(
                context,
                "Back to main",
                () {
                  Navigator.pushNamed(context, RouteManagerProvider.mainPage);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
