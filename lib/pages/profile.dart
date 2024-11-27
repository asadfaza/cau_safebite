import 'package:cau_safebite/auth/login_page.dart';
import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:cau_safebite/data_json.dart';
import 'package:cau_safebite/welcome_pages/welcome_page.dart';
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
  String religious = 'Not selected';
  String gender = 'Undefined';
  DateTime dateOfBirth = DateTime.now();
  int calculatedAge = 0;
  final double dailyGoalCalories = 2000; // Example calorie goal
  double consumedCalories = 0;

  void calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Adjust age if the birthdate hasn't occurred yet this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    setState(() {
      calculatedAge = age;
    });
  }

  @override
  void initState() {
    super.initState();
    for (var meal in mealPlan[1]['meals']) {
      if (meal['isConsumed']) {
        consumedCalories += meal['calories'];
      }
    }
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
            gender = userDoc['gender'] ?? 'Undefined';
            religious = userDoc['religious'] ?? 'Not selected';
            Timestamp date = userDoc['born'];
            dateOfBirth = date.toDate();
            calculateAge(dateOfBirth);
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

  void onGoalTap(String goal) {
    // Action to be performed when a goal is tapped
    print("Tapped on $goal");
  }

  @override
  Widget build(BuildContext context) {
    double progress = consumedCalories / dailyGoalCalories;
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
        child: ListView(
          children: [
            // Display user name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName ?? "Loading...",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomePage(
                                  index: 3,
                                ))),
                    icon: Icon(Icons.edit))
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Age",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  '$calculatedAge',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gender",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  gender,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Religious",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  religious,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
            // Display allergies
            Text(
              "Allergies",
              style: TextStyle(
                fontFamily: 'Poppins',
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
                fontFamily: 'Poppins',
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
                        label: Text(
                          disease,
                          style: TextStyle(
                            fontFamily: 'Inter',
                          ),
                        ),
                        backgroundColor: Colors.red[100],
                      ))
                  .toList(),
            ),

            SizedBox(height: 16),

            Center(
              child: Column(
                children: [
                  Text(
                    "Daily Calorie Goal",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.orange,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${(progress * 100).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$consumedCalories / $dailyGoalCalories kcal",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
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

class AvoidItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  AvoidItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: secondColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
