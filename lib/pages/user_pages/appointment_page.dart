import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/misc/validators.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  // currently logged in patient
  final currentUser = FirebaseAuth.instance.currentUser;
  // all the patients
  final allUsers = FirebaseFirestore.instance.collection("Appointments");

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
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
                        "You can book an appointment here",
                      ),
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: _emailController,
                      validator: validateCap,
                      decoration: formS(
                          "Please enter your email here", "", Icons.person),
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: _reasonController,
                      validator: validateCap,
                      decoration:
                          formS("Provide a reason for booking", "", Icons.edit),
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: _dateController,
                      readonly: true,
                      validator: validateCap,
                      decoration: formS(
                          "Appointment Date", "", Icons.calendar_view_month),
                      onPressed: () {
                        _selectDate();
                      },
                    ),
                    const SizedBox(height: 20),
                    rslButton(context, "Submit", () {
                      if (_formKey.currentState!.validate()) {
                        User? userCredential =
                            FirebaseAuth.instance.currentUser;

                        FirebaseFirestore.instance
                            .collection("Appointments")
                            .doc(userCredential?.email)
                            .set(
                          {
                            "Reason": _reasonController.text,
                            "Date": _dateController.text,
                            "Email": _emailController.text
                          },
                        );

                        log("Appointment has been made.");

                        // Show a confirmation message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${currentUser?.displayName} your appoint is received!')),
                        );

                        // Clear the form
                        _dateController.clear();
                        _reasonController.clear();
                        _emailController.clear();
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
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
