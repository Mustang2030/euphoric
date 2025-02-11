import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/pages/admin_pages/admin_panel.dart';
import 'package:euphoric/pages/auth_pages/main_page.dart';
import 'package:euphoric/pages/doctor_pages/doctor_panel.dart';
import 'package:euphoric/pages/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  Future<Widget> getUserRolePage(String userId) async {
    // Check if user is an admin
    DocumentSnapshot adminSnapshot =
        await FirebaseFirestore.instance.collection('Admins').doc(userId).get();
    if (adminSnapshot.exists) {
      return const AdminPanel();
    }

    // Check if user is a patient
    DocumentSnapshot patientSnapshot = await FirebaseFirestore.instance
        .collection('Patients')
        .doc(userId)
        .get();
    if (patientSnapshot.exists) {
      return const MainPage();
    }

    // Check if user is a doctor
    DocumentSnapshot doctorSnapshot = await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(userId)
        .get();
    if (doctorSnapshot.exists) {
      return const DoctorPanel();
    }

    // If user role is not found
    return const SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final userId = snapshot.data!.email;
            if (userId == null) {
              return const SplashScreen(); // if userId is null
            }
            return FutureBuilder<Widget>(
              future: getUserRolePage(userId),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (roleSnapshot.hasData) {
                  return roleSnapshot.data!;
                } else {
                  return const SplashScreen(); // handle case where roleSnapshot has no data
                }
              },
            );
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
