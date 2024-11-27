import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:cau_safebite/data_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'No Name';

  Future<void> fetchUserData() async {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      // Ensure user is signed in and has an email
      if (user != null && user.email != null) {
        setState(() {
          userName = user.displayName ?? "No Name";
        });
      } else {
        print("User is not signed in or does not have an email.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: DraggableHome(
            appBarColor: Color(0xffDFE8F3),
            title: Text(
              'Our recomandation',
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
            ),
            headerWidget: Container(
                color: Colors.blue.shade50,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: Color(0xffA3CFF3),
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                              onPressed: () {},
                              icon:
                                  SvgPicture.asset('assets/notification.svg')),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Hello, $userName',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Discover better way of living',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                        )
                      ],
                    )
                  ],
                )),
            body: [
              Container(
                padding: EdgeInsets.all(5),
                width: screenSize.width * 0.9,
                height: 5000,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: foodItems.length,
                  itemBuilder: (context, index) {
                    final food = foodItems[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemDetailScreen(food: food),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  // Food Image
                                  // Container(
                                  //   height: screenSize.width * 0.35,
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.grey.shade300,
                                  //       borderRadius:
                                  //           BorderRadius.circular(10)),
                                  // ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.asset(
                                      food.image_url,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Heart icon
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food.category,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      food.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Safe Icon
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "safe",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              )
            ]));
  }
}

class FoodItem {
  final String category;
  final String title;
  final String description;
  final List<String> ingredients;
  final double protein;
  final double fats;
  final double carbohydrates;
  final double fiber;
  final String image_url;

  FoodItem(
      {required this.category,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.protein,
      required this.fats,
      required this.carbohydrates,
      required this.fiber,
      required this.image_url});

  // Factory method to create a FoodItem from a JSON map
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
        category: json['category'],
        title: json['title'],
        description: json['description'],
        ingredients: List<String>.from(json['ingredients']),
        protein: json['protein'],
        fats: json['fats'],
        carbohydrates: json['carbohydrates'],
        fiber: json['fiber'],
        image_url: json['image_url']);
  }
}

class ItemDetailScreen extends StatelessWidget {
  final FoodItem food;

  ItemDetailScreen({required this.food});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.category),
        backgroundColor: bColor,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              User? user = FirebaseAuth.instance.currentUser;
              addToFavorites(user!.email ?? 'no email', food.title,
                  food.category, food.image_url);
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey.shade300,
                  //       borderRadius: BorderRadius.circular(10)),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      food.image_url,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "423 kcal / 100 g",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Nutrient Values Section
              Text(
                "Nutrient Values",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              NutrientRow(
                  label: "Protein", value: food.protein, color: Colors.green),
              NutrientRow(
                  label: "Fats", value: food.fats, color: Colors.orange),
              NutrientRow(
                  label: "Carbohydrates",
                  value: food.carbohydrates,
                  color: Colors.blue),
              NutrientRow(label: "Fiber", value: food.fiber, color: Colors.red),

              SizedBox(height: 16),

              // Ingredients and Allergens
              Text(
                "Ingredients: ${food.ingredients.join(", ")}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),

              // Allergen Tags
              Wrap(
                spacing: 8,
                children: food.ingredients.map((ingredient) {
                  return Chip(
                    label: Text(ingredient),
                    backgroundColor: Colors.orange[100],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addToFavorites(
      String email, String title, String category, String imageUrl) async {
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favorites');

    await favorites.doc(email).set({
      'favorites': FieldValue.arrayUnion([
        {
          'title': title,
          'category': category,
          'imageUrl': imageUrl,
        }
      ])
    }, SetOptions(merge: true));
  }
}

// NutrientRow widget with progress bar styling
class NutrientRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  NutrientRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text("${value}g / 100g", style: TextStyle(color: Colors.grey),),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(10),
                  value: value /
                      100, // Adjust this scale based on max value for each nutrient
                  color: color,
                  backgroundColor: color.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
