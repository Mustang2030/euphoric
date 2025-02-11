import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Management App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Welcome ${user?.displayName}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      decorationThickness: BorderSide.strokeAlignCenter),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OptionsButton(
                          text: "Appointment",
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.appointmentPage);
                          }),
                      OptionsButton(
                          text: "My Profile",
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.userProfilePage);
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OptionsButton(
                          text: "Review",
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.reviewPage);
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                rslButton(
                  context,
                  "LOGOUT",
                  () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(
                        context, RouteManagerProvider.loginPage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
