import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:cau_safebite/data_json.dart';
import 'package:flutter/material.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  // Variable to keep track of the selected day index
  int selectedDayIndex = 0;

  // Function to calculate the total calories for the selected day
  int getTotalCaloriesForDay(int dayIndex) {
    int totalCalories = 0;
    for (var meal in mealPlan[dayIndex]['meals']) {
      totalCalories += meal['calories'] as int;
    }
    return totalCalories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Weekly Meal Plan',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: bColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Days of the week row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < mealPlan.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = i; // Update selected day
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          mealPlan[i]['date'],
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: selectedDayIndex == i
                                ? secondColor
                                : Colors.black, // Highlight selected day
                          ),
                        ),
                        Text(
                          mealPlan[i]['day'],
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: selectedDayIndex == i
                                ? secondColor
                                : Colors.black, // Highlight selected day
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: mealPlan[selectedDayIndex]['meals'].length,
                itemBuilder: (context, index) {
                  var meal = mealPlan[selectedDayIndex]['meals'][index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffA3CFF3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Meal Image
                        // Container(
                        //   height: 60,
                        //   width: 60,
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey.shade300,
                        //       borderRadius: BorderRadius.circular(10)),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            meal['imageUrl'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        // Meal Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal['category'],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                meal['title'],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text('${meal['calories']} kcal',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Colors.grey)),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              (meal['isConsumed'])
                                  ? setState(() {
                                      meal['isConsumed'] = false;
                                    })
                                  : setState(() {
                                      meal['isConsumed'] = true;
                                    });
                            },
                            icon: Icon((meal['isConsumed'])
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank))
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            // Total Calories Summary
            Text(
              'Total Calories: ${getTotalCaloriesForDay(selectedDayIndex)} kcal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
