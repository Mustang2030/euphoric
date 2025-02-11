import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:euphoric/misc/validators.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _dOBController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _idController.dispose();
    _dOBController.dispose();
    _contactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Patient Registration",
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    //logo has to go here
                    StyledFormField(
                      controller: _nameController,
                      validator: validateCap,
                      decoration: formS("Name", "", Icons.abc_outlined),
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: _surnameController,
                      validator: validateCap,
                      decoration: formS("Surname", "", Icons.abc_sharp),
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
                    StyledFormField(
                      readonly: false,
                      controller: _dOBController,
                      validator: validDate,
                      decoration: formS("Date Of Birth", "", Icons.abc_sharp),
                      onPressed: () {
                        _selectDate();
                      },
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: _idController,
                      validator: validateId,
                      decoration:
                          formS("ID Number", "", Icons.perm_identity_sharp),
                    ),
                    const SizedBox(height: 20),
                    StyledFormField(
                      controller: _contactController,
                      validator: validateCap,
                      decoration: formS("Contact", "", Icons.abc_sharp),
                    ),
                    const SizedBox(height: 20),

                    rslButton(context, "REGISTER", () {
                      if (_formKey.currentState!.validate()) {
                        register();
                        if (_auth?.displayName != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Hello ${_auth!.displayName}. You have successfuly registered as a patient"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "You have successfuly registered as a patient"),
                            ),
                          );
                        }
                        Navigator.pushNamed(
                            context, RouteManagerProvider.loginPage);
                      }
                    }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.lightGreen),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.loginPage);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not a patient?",
                          style: TextStyle(color: Colors.lightGreen),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RouteManagerProvider.adminRegistrationPage);
                          },
                          child: const Text(
                            "Go back",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dOBController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future register() async {
    {
      //create user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      //after user is created, create a new collection in cloud firestore called patients
      FirebaseFirestore.instance
          .collection("Patients")
          .doc(userCredential.user?.email)
          .set(
        {
          "First Name": _nameController.text,
          "Surname": _surnameController.text,
          "Email": _emailController.text,
          "Password": _passwordController.text,
          "ID Number": _idController.text,
          "Date Of Birth": _dOBController.text,
          "Contact Number": _contactController.text,
        },
      ).then(
        (value) => FirebaseAuth.instance.currentUser!
            .updateDisplayName(_nameController.text),
      );
    }
  }
}
