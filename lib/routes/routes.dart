import 'package:euphoric/auth/account_auth.dart';
import 'package:euphoric/pages/admin_pages/ad_registration.dart';
import 'package:euphoric/pages/admin_pages/admin_panel.dart';
import 'package:euphoric/pages/admin_pages/appointment_page.dart';
import 'package:euphoric/pages/admin_pages/review_page.dart';
import 'package:euphoric/pages/auth_pages/login_page.dart';
import 'package:euphoric/pages/auth_pages/main_page.dart';
import 'package:euphoric/pages/auth_pages/registration_page.dart';
import 'package:euphoric/pages/doctor_pages/d_appointment_page.dart';
import 'package:euphoric/pages/doctor_pages/d_registration.dart';
import 'package:euphoric/pages/doctor_pages/doctor_profile.dart';
import 'package:euphoric/pages/doctor_pages/doctor_panel.dart';
import 'package:euphoric/pages/splash_screen/splash_screen.dart';
import 'package:euphoric/pages/user_pages/appointment_page.dart';
import 'package:euphoric/pages/user_pages/profile_page.dart';
import 'package:euphoric/pages/user_pages/review_page.dart';
import 'package:flutter/material.dart';

//Using a provider for routes

class RouteManagerProvider with ChangeNotifier {
  static const String authPage = '/';
  static const String splashScreen = '/splashScreen';
  static const String adminRegistrationPage = '/adminRegistrationPage';
  static const String adminPanel = '/adminPanel';
  static const String adminAppointment = '/adminAppointment';
  static const String adminReview = '/adminReview';
  static const String doctorRegistration = "/doctorRegistration";
  static const String doctorAppointment = "/doctorAppointment";
  static const String doctorProfile = "/doctorProfile";
  static const String doctorPanel = "/doctorPanel";
  static const String registrationPage = '/registrationPage';
  static const String loginPage = '/loginPage';
  static const String mainPage = '/mainPage';
  static const String appointmentPage = '/appointmentPage';
  static const String userProfilePage = '/userProfilePage';
  static const String reviewPage = '/reviewPage';

  // Route generator function
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authPage:
        return MaterialPageRoute(
          builder: (context) => const AuthenticationPage(),
        );

      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case adminRegistrationPage:
        return MaterialPageRoute(
          builder: (context) => const AdminRegistrationPage(),
        );

      case adminPanel:
        return MaterialPageRoute(
          builder: (context) => const AdminPanel(),
        );

      case adminAppointment:
        return MaterialPageRoute(
          builder: (context) => const AppointmentPagea(),
        );

      case adminReview:
        return MaterialPageRoute(
          builder: (context) => const ReviewPagea(),
        );

      case doctorRegistration:
        return MaterialPageRoute(
          builder: (context) => const DoctorRegistrationPage(),
        );

      case doctorAppointment:
        return MaterialPageRoute(
          builder: (context) => const AppointmentPaged(),
        );

      case doctorProfile:
        return MaterialPageRoute(
          builder: (context) => const DoctorProfilePage(),
        );

      case doctorPanel:
        return MaterialPageRoute(
          builder: (context) => const DoctorPanel(),
        );

      case registrationPage:
        return MaterialPageRoute(
          builder: (context) => const RegistrationPage(),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case mainPage:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );

      case appointmentPage:
        return MaterialPageRoute(
          builder: (context) => const AppointmentPage(),
        );

      case userProfilePage:
        return MaterialPageRoute(
          builder: (context) => const UserProfilePage(),
        );

      case reviewPage:
        return MaterialPageRoute(
          builder: (context) => const ReviewPage(),
        );

      default:
        throw const FormatException('Page does not exist.');
    }
  }
}
