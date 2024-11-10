import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:flutter/material.dart';

class MealPlanPage extends StatelessWidget {
  List<Map<String, dynamic>> mealPlan = [
    {
      'date': '10',
      'day': 'Sun',
      'meals': [
        {
          'title': 'Fried Egg on Toast',
          'category': 'Breakfast',
          'calories': 210,
          'description': 'A simple breakfast with fried egg on toast.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0037.png'
        },
        {
          'title': 'Greek Salad',
          'category': 'Snack',
          'calories': 120,
          'description': 'A refreshing Greek salad with feta cheese.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0009.png'
        },
        {
          'title': 'Grilled Chicken',
          'category': 'Lunch',
          'calories': 350,
          'description': 'Tender grilled chicken breast.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0294.png'
        },
        {
          'title': 'Margherita Pizza',
          'category': 'Dinner',
          'calories': 600,
          'description': 'Classic Margherita pizza with tomato and basil.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0357.png'
        },
      ],
    },
    {
      'date': '11',
      'day': 'Mon',
      'meals': [
        {
          'title': 'Oatmeal with Berries',
          'category': 'Breakfast',
          'calories': 200,
          'description': 'Warm oatmeal topped with fresh berries.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0021.png'
        },
        {
          'title': 'Hummus and Carrot Sticks',
          'category': 'Snack',
          'calories': 100,
          'description': 'Healthy snack of hummus with fresh carrot sticks.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0010.png'
        },
        {
          'title': 'Vegetable Stir-fry',
          'category': 'Lunch',
          'calories': 250,
          'description': 'Mixed vegetables stir-fried with soy sauce.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0230.png'
        },
        {
          'title': 'Spaghetti Bolognese',
          'category': 'Dinner',
          'calories': 550,
          'description': 'Classic spaghetti with bolognese sauce.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0375.png'
        },
      ],
    },
    {
      'date': '12',
      'day': 'Tue',
      'meals': [
        {
          'title': 'Pancakes with Syrup',
          'category': 'Breakfast',
          'calories': 300,
          'description': 'Fluffy pancakes with maple syrup.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0040.png'
        },
        {
          'title': 'Apple Slices with Peanut Butter',
          'category': 'Snack',
          'calories': 150,
          'description': 'Crisp apple slices served with peanut butter.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0012.png'
        },
        {
          'title': 'Tuna Sandwich',
          'category': 'Lunch',
          'calories': 350,
          'description': 'Tuna salad sandwich on whole grain bread.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0315.png'
        },
        {
          'title': 'Chicken Caesar Salad',
          'category': 'Dinner',
          'calories': 400,
          'description': 'Classic Caesar salad with grilled chicken.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0290.png'
        },
      ],
    },
    {
      'date': '13',
      'day': 'Wed',
      'meals': [
        {
          'title': 'Smoothie Bowl',
          'category': 'Breakfast',
          'calories': 250,
          'description': 'Smoothie bowl topped with fruits and nuts.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0033.png'
        },
        {
          'title': 'Yogurt with Granola',
          'category': 'Snack',
          'calories': 180,
          'description': 'Greek yogurt topped with crunchy granola.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0008.png'
        },
        {
          'title': 'Turkey Wrap',
          'category': 'Lunch',
          'calories': 320,
          'description': 'Wrap filled with turkey, lettuce, and tomato.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0322.png'
        },
        {
          'title': 'Vegetable Soup',
          'category': 'Dinner',
          'calories': 220,
          'description': 'Warm vegetable soup with a side of bread.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0278.png'
        },
      ],
    },
    {
      'date': '14',
      'day': 'Thu',
      'meals': [
        {
          'title': 'Avocado Toast',
          'category': 'Breakfast',
          'calories': 250,
          'description': 'Whole grain toast with mashed avocado.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0039.png'
        },
        {
          'title': 'Banana Smoothie',
          'category': 'Snack',
          'calories': 180,
          'description': 'Smoothie made with banana and almond milk.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0011.png'
        },
        {
          'title': 'Salmon Salad',
          'category': 'Lunch',
          'calories': 400,
          'description': 'Fresh salad with grilled salmon on top.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0250.png'
        },
        {
          'title': 'Chicken Fajitas',
          'category': 'Dinner',
          'calories': 450,
          'description': 'Mexican-style chicken fajitas with peppers.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0360.png'
        },
      ],
    },
    {
      'date': '15',
      'day': 'Fri',
      'meals': [
        {
          'title': 'Bagel with Cream Cheese',
          'category': 'Breakfast',
          'calories': 270,
          'description': 'Bagel topped with smooth cream cheese.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0034.png'
        },
        {
          'title': 'Mixed Nuts',
          'category': 'Snack',
          'calories': 200,
          'description': 'Assortment of roasted nuts.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0006.png'
        },
        {
          'title': 'Pasta Primavera',
          'category': 'Lunch',
          'calories': 420,
          'description': 'Pasta with mixed vegetables in a light sauce.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0340.png'
        },
        {
          'title': 'Steak with Vegetables',
          'category': 'Dinner',
          'calories': 550,
          'description': 'Grilled steak with a side of mixed vegetables.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0365.png'
        },
      ],
    },
    {
      'date': '16',
      'day': 'Sat',
      'meals': [
        {
          'title': 'French Toast',
          'category': 'Breakfast',
          'calories': 320,
          'description': 'French toast topped with syrup and berries.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0045.png'
        },
        {
          'title': 'Protein Bar',
          'category': 'Snack',
          'calories': 150,
          'description': 'Chocolate-flavored protein bar.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0005.png'
        },
        {
          'title': 'Chicken Pasta',
          'category': 'Lunch',
          'calories': 480,
          'description': 'Creamy pasta with grilled chicken.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0325.png'
        },
        {
          'title': 'Sushi Rolls',
          'category': 'Dinner',
          'calories': 400,
          'description': 'Assorted sushi rolls with fresh fish and rice.',
          'image_url': 'https://cau-hackaton.s3.amazonaws.com/images/0370.png'
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Meal Plan'),
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
                for (var day in mealPlan)
                  Column(
                    children: [
                      Text(
                        day['date'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(day['day'], style: TextStyle(fontSize: 14)),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: mealPlan[0]['meals'].length,
                itemBuilder: (context, index) {
                  var meal = mealPlan[0]['meals'][index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Meal Image
                        Image.network(
                          meal['image_url'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(meal['title']),
                              Text('${meal['calories']} kcal',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
