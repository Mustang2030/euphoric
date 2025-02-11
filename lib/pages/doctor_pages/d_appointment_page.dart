import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:flutter/material.dart';

class AppointmentPaged extends StatefulWidget {
  const AppointmentPaged({super.key});

  @override
  State<AppointmentPaged> createState() => _AppointmentPagedState();
}

class _AppointmentPagedState extends State<AppointmentPaged> {
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
              child: Text("Patients haven't made appointments yet..."),
            );
          }
          final appointments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              var appointment = appointments[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("A request from: ${appointment["Email"]}"),
                    UserInf(
                        boxName:
                            "Appointment will be on this date: ${appointment["Date"]}",
                        text: "Why patient is coming: ${appointment["Reason"]}",
                        iconButton: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 28,
                          ),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.lightGreen,
                                title: const Text(
                                  "Will you accept this patients appointment?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
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
                        onPressed: () {}),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: () {}),
    );
  }

  Future<void> deleteAppointment(String appointment) async {
    try {
      await FirebaseFirestore.instance
          .collection("Appointments")
          .doc(appointment)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment accepted.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to respond Appointment: $e')),
      );
    }
  }
}
