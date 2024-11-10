import 'package:cau_safebite/auth/login_page.dart';
import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:cau_safebite/welcome_pages/customize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  List<String> allergies = [];
  List<String> diseases = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      // Ensure user is signed in and has an email
      if (user != null && user.email != null) {
        final String email = user.email!;

        // Fetch user data from Firestore using email as document ID
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName =
                user.displayName ?? "No Name"; // Get display name or fallback
            allergies = List<String>.from(userDoc['allergies'] ?? []);
            diseases = List<String>.from(userDoc['diseases'] ?? []);
          });
        } else {
          print("No data found for this user.");
        }
      } else {
        print("User is not signed in or does not have an email.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bColor,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => confirmSignOut(context),
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display user name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName ?? "Loading...",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
              onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => AllergySelectionScreen())),
              icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(height: 16.0),

            // Display allergies
            Text(
              "Allergies",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: allergies
                  .map((allergy) => Chip(
                        label: Text(allergy),
                        backgroundColor: Colors.green[100],
                      ))
                  .toList(),
            ),
            SizedBox(height: 16.0),

            // Display diseases
            Text(
              "Diseases",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: diseases
                  .map((disease) => Chip(
                        label: Text(disease),
                        backgroundColor: Colors.red[100],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );

    // If the user confirms, log them out
    if (shouldLogout ?? false) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      await FirebaseAuth.instance.signOut();
    }
  }
}
