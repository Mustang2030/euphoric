import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:flutter/material.dart';

class AppointmentPagea extends StatefulWidget {
  const AppointmentPagea({super.key});

  @override
  State<AppointmentPagea> createState() => _AppointmentPageaState();
}

class _AppointmentPageaState extends State<AppointmentPagea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("Appointments").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Errot ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docChanges.isEmpty) {
            return const Center(
              child: Text("Patients haven't made appointments"),
            );
          }
          final appointments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              var appointment = appointments[index];
              return Column(
                children: [
                  UserInf(
                    email: appointment["Email"],
                    text: appointment["Date"],
                    boxName: appointment["Reason"],
                    iconButton: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.lightGreen,
                            title: const Text(
                              "Are you sure you want to delete this review?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  deleteAppointment(appointment.id).then(
                                    (value) => Navigator.of(context).pop(),
                                  );
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "No",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  rslButton(context, "Back to main", () {
                    Navigator.pushNamed(
                        context, RouteManagerProvider.adminPanel);
                  })
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> deleteAppointment(String appointment) async {
    try {
      await FirebaseFirestore.instance
          .collection("Appointments")
          .doc(appointment)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete Appointment: $e')),
      );
    }
  }
}
