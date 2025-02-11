import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:euphoric/misc/constants.dart';
import 'package:euphoric/routes/routes.dart';
import 'package:flutter/material.dart';

class ReviewPagea extends StatefulWidget {
  const ReviewPagea({super.key});

  @override
  State<ReviewPagea> createState() => _ReviewPageaState();
}

class _ReviewPageaState extends State<ReviewPagea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Reviews").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Patients haven't made reviews yet..."),
            );
          }
          final reviews = snapshot.data!.docs;

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              var review = reviews[index];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    UserInf(
                      boxName: review["Hospital Name"],
                      text: review["Review"],
                      onPressed: () {},
                      iconButton: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.lightGreen,
                              title: const Text(
                                "Are you sure you want to delete this review?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    deleteRev(review.id).then(
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
                      iconButton2: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editField(review.id, "Review");
                        },
                      ),
                    ),
                    rslButton(context, "Back to main", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.adminPanel);
                    })
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> deleteRev(String rev) async {
    try {
      await FirebaseFirestore.instance.collection("Reviews").doc(rev).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete review: $e')),
      );
    }
  }

  Future<void> editField(String reviewId, String field) async {
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
    // Update data in Firestore
    if (changeV.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("Reviews")
          .doc(reviewId)
          .update({field: changeV});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review updated successfully')),
      );
    }
  }
}
