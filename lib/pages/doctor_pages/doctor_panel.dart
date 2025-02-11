import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorPanel extends StatefulWidget {
  const DoctorPanel({super.key});

  @override
  State<DoctorPanel> createState() => _DoctorPanelState();
}

class _DoctorPanelState extends State<DoctorPanel> {
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
                  "Welcome Doctor ${user?.displayName}",
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
                            Navigator.pushNamed(context,
                                RouteManagerProvider.doctorAppointment);
                          }),
                      OptionsButton(
                          text: "My Profile",
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.doctorProfile);
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
