import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to Euphoric Hospital Management",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/images/lo.jpg', scale: 1.5),
                const SizedBox(height: 20),
                rslButton(context, "Register as Admin", () {
                  Navigator.pushNamed(
                      context, RouteManagerProvider.adminRegistrationPage);
                }),
                const SizedBox(height: 20),
                rslButton(
                  context,
                  "Register as Patient",
                  () {
                    Navigator.pushNamed(
                        context, RouteManagerProvider.registrationPage);
                  },
                ),
                const SizedBox(height: 20),
                rslButton(
                  context,
                  "Register as Doctor",
                  () {
                    Navigator.pushNamed(
                        context, RouteManagerProvider.doctorRegistration);
                  },
                ),
                const SizedBox(height: 20),
                rslButton(
                  context,
                  "Login",
                  () {
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
