import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // Reference to Firestore collection
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Save selected allergies and diseases to Firestore using the authenticated user's email as the document ID
  Future<void> saveAllergiesAndDiseases({
    required List<String> selectedAllergies,
    required List<String> selectedDiseases,
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
}

class AllergySelectionScreen extends StatefulWidget {
  const AllergySelectionScreen({super.key});

  @override
  _AllergySelectionScreenState createState() => _AllergySelectionScreenState();
}

class _AllergySelectionScreenState extends State<AllergySelectionScreen> {
  final List<String> allergies = [
    "peanuts",
    "tree nuts",
    "milk",
    "eggs",
    "shellfish",
    "fish",
    "wheat",
    "soy",
    "sesame",
    "gluten",
    "corn",
    "latex",
    "pollen",
    "dust mites",
    "mold",
    "animal dander",
    "insect stings",
    "medications",
    "fragrances",
    "food additives",
    "coconut",
    "tomatoes",
    "citrus fruits",
    "bananas",
    "avocados",
    "kiwi",
    "strawberries",
    "garlic",
    "mustard",
    "alcohol",
  ];
  final List<String> diseases = [
    "Diabetes",
    "Hypertension",
    "Heart Disease",
    "Asthma",
    "Chronic Obstructive Pulmonary Disease (COPD)",
    "Cancer",
    "Arthritis",
    "Alzheimer's Disease",
    "Stroke",
    "Kidney Disease",
    "Liver Disease",
    "Parkinson's Disease",
    "Epilepsy",
    "Multiple Sclerosis",
    "HIV/AIDS",
    "Osteoporosis",
    "Tuberculosis",
    "Hepatitis",
    "Migraine",
    "Depression",
    "Anxiety Disorders",
    "Obesity",
    "Celiac Disease",
    "Irritable Bowel Syndrome (IBS)",
    "Crohn's Disease",
    "Ulcerative Colitis",
    "Lupus",
    "Psoriasis",
    "Eczema",
    "Thyroid Disorders",
  ];

  List<String> selectedAllergies = [];
  List<String> selectedDiseases = [];
  String searchQuery = "";
  String searchQuerySecond = "";
  int _index = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        child: Column(
          children: [
            // Search bar
            SizedBox(
              height: 50,
              child: TextField(
                onChanged: (value) {
                  (_index == 0)
                      ? setState(() {
                          searchQuery = value.toLowerCase();
                        })
                      : setState(() {
                          searchQuerySecond = value.toLowerCase();
                        });
                },
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.grey,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  (_index == 0) ? "Allergies" : "Disease",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            // SizedBox(height: 16),
            // Text(
            //   "Select your known allergies by tapping on the items below. ",
            //   style: TextStyle(fontSize: 15, color: Colors.green),
            // ),
            SizedBox(height: 20),
            // Wrap with chips
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5.0,
                  runSpacing: 1.0,
                  children: (_index == 0)
                      ? allergies
                          .where((allergy) => allergy.contains(searchQuery))
                          .map((allergy) => ChoiceChip(
                                label: Text(
                                  allergy,
                                  style: TextStyle(
                                    color: selectedAllergies.contains(allergy)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: selectedAllergies.contains(allergy),
                                selectedColor: Colors.green,
                                backgroundColor: Colors.white,
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                onSelected: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedAllergies.add(allergy);
                                    } else {
                                      selectedAllergies.remove(allergy);
                                    }
                                  });
                                },
                              ))
                          .toList()
                      : diseases
                          .where((disease) => disease.contains(searchQuery))
                          .map((disease) => ChoiceChip(
                                label: Text(
                                  disease,
                                  style: TextStyle(
                                    color: selectedDiseases.contains(disease)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: selectedDiseases.contains(disease),
                                selectedColor: Colors.green,
                                backgroundColor: Colors.white,
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                onSelected: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      selectedDiseases.add(disease);
                                    } else {
                                      selectedDiseases.remove(disease);
                                    }
                                  });
                                },
                              ))
                          .toList(),
                ),
              ),
            ),
            (_index == 0)
                ? SizedBox(
                    width: 250,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            _index = 1;
                          });
                        },
                        style:
                            buttonStyle(screenSize.width, Colors.grey.shade200),
                        child: Text("Next...")),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _index = 0;
                              });
                            },
                            style: buttonStyle(
                                screenSize.width, Colors.grey.shade200),
                            child: Text("Previous")),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = !_isLoading;
                              });
                              confirmSave(context);
                            },
                            style: buttonStyle(screenSize.width, secondColor),
                            child: _isLoading
                                ? SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ))
                                : Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  )),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Future<void> confirmSave(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Save changes"),
          content: Text("Are you sure?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Save"),
            ),
          ],
        );
      },
    );

    // If the user confirms, log them out
    if (shouldLogout ?? false) {
      final FirestoreService firestoreService = FirestoreService();
      firestoreService
          .saveAllergiesAndDiseases(
            selectedAllergies: selectedAllergies,
            selectedDiseases: selectedDiseases,
          )
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/', (route) => false));
    } else
      setState(() {
        _isLoading = !_isLoading;
      });
  }
}
