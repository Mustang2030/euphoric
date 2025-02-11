import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Welcome to the admin panel ${auth!.displayName}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionsButton(
                    text: "Appointment",
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.adminAppointment);
                    }),
                OptionsButton(
                    text: "Reviews",
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.adminReview);
                    }),
              ],
            ),
            rslButton(
              context,
              "LOGOUT",
              () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, RouteManagerProvider.loginPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
