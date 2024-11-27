import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WaitingWidget extends StatefulWidget {
  final List<String> selectedAllergies;
  final List<String> selectedDiseases;
  final List<String> selectedDiets;
  final DateTime selectedDate;
  final String gender;
  final String religious;

  const WaitingWidget({
    required this.selectedAllergies,
    required this.selectedDiseases,
    required this.selectedDiets,
    required this.selectedDate,
    required this.gender,
    required this.religious,
    Key? key,
  }) : super(key: key);

  @override
  State<WaitingWidget> createState() => _WaitingWidgetState();
}

class _WaitingWidgetState extends State<WaitingWidget> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Save selected allergies and diseases to Firestore using the authenticated user's email as the document ID
  Future<void> saveAllergiesAndDiseases({
    required List<String> selectedAllergies,
    required List<String> selectedDiseases,
    required List<String> selectedDiets,
    required DateTime selectedDate,
    required String gender,
    required String religious,
  }) async {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      // Ensure user is signed in and has an email
      if (user != null && user.email != null) {
        final String email = user.email!; // Use user's email as document ID

        // Use email as the document ID
        await usersCollection.doc(email).set({
          'allergies': selectedAllergies,
          'diseases': selectedDiseases,
          'diet': selectedDiets,
          'born': selectedDate,
          'gender': gender,
          'religious': religious,
          'updated_at': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        print("Allergies and diseases saved successfully for $email!");
      } else {
        print("User is not signed in or does not have an email.");
      }
    } catch (e) {
      print("Error saving allergies and diseases: $e");
    }
  }

  void performParallelTasks() async {
    // Start both tasks
    Future.delayed(Duration(seconds: 10), () {
      print("10-second delay finished.");
    });

    await saveAllergiesAndDiseases(
        religious: widget.religious,
        selectedAllergies: widget.selectedAllergies,
        selectedDate: widget.selectedDate,
        selectedDiets: widget.selectedDiets,
        selectedDiseases: widget.selectedDiseases,
        gender: widget.gender);

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void initState() {
    performParallelTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'We`re setting everything',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  'up for you',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
                CircularProgressIndicator(
                  color: Colors.black,
                )
              ],
            ),
          ),
          Center(child: Image.asset('assets/AI.png', height: 50, width: 50))
        ],
      ),
    );
  }
}