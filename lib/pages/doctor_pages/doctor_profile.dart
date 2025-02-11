import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/pages/auth_pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  // currently logged in patient
  final currentUser = FirebaseAuth.instance.currentUser;
  // all the patients
  final allUsers = FirebaseFirestore.instance.collection("Doctors");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Doctors")
            .doc(currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userdata = snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
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
                          "Doctor Details",
                        ),
                      ),
                      UserInf(
                        text: userdata['First Name'],
                        boxName: "First Name",
                        iconButton2: IconButton(
                            onPressed: () {
                              editField("First Name");
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                      UserInf(
                          text: userdata['Surname'],
                          boxName: "Last Name",
                          iconButton2: IconButton(
                              onPressed: () {
                                editField("Last Name");
                              },
                              icon: const Icon(Icons.edit))),
                      UserInf(
                          text: userdata['Email'],
                          boxName: "Email",
                          iconButton2: IconButton(
                              onPressed: () {
                                editField("Email");
                              },
                              icon: const Icon(Icons.edit))),
                      UserInf(
                          text: userdata['Password'],
                          boxName: "Password",
                          iconButton2: IconButton(
                              onPressed: () {
                                editField("Password");
                              },
                              icon: const Icon(Icons.edit))),
                      UserInf(
                          text: userdata['ID Number'],
                          boxName: "ID Number",
                          iconButton2: IconButton(
                              onPressed: () {
                                editField("ID number");
                              },
                              icon: const Icon(Icons.edit))),
                      UserInf(
                          text: userdata['Date Of Birth'],
                          boxName: "Date Of Birth",
                          iconButton2: IconButton(
                              onPressed: () {
                                editField("Date Of Birth");
                              },
                              icon: const Icon(Icons.edit))),
                      UserInf(
                        text: userdata['Contact Number'],
                        boxName: "Contact Number",
                        iconButton2: IconButton(
                          onPressed: () {
                            editField("Contact Number");
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: rslButton(
                          context,
                          "Back to main",
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> editField(String field) async {
    String changeV = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "Change your $field",
          style: const TextStyle(color: Colors.white, fontSize: 19),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter your new $field here",
            hoverColor: Colors.black,
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          onChanged: (value) {
            changeV = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          
          TextButton(
            onPressed: () => Navigator.of(context).pop(changeV),
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    //update data in Firestore
    if (changeV.trim().isNotEmpty) {
      await allUsers.doc(currentUser!.email).update({field: changeV}).then(
        (value) =>
            FirebaseAuth.instance.currentUser!.updateDisplayName(changeV),
      );
    }
  }
}
