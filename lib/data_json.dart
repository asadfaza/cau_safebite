import 'dart:convert';

import 'package:cau_safebite/pages/home_page.dart';

// Assuming jsonData is the JSON string from your example
const jsonData = '''[
    {
        "category": "fruit",
        "title": "Oranges",
        "description": "Oranges are juicy, sweet, and slightly tangy citrus fruits known for their high vitamin C content.",
        "ingredients": [
            "orange"
        ],
        "protein": 1.2,
        "fats": 0.2,
        "carbohydrates": 11.8,
        "fiber": 2.4,
        "image_url": "assets/images/0001.png"
    },
    {
        "category": "fruit",
        "title": "Apples",
        "description": "Apples are crisp and refreshing fruits, available in various colors, offering a balance of sweetness and acidity.",
        "ingredients": [
            "apple"
        ],
        "protein": 0.3,
        "fats": 0.2,
        "carbohydrates": 13.8,
        "fiber": 2.4,
        "image_url": "assets/images/0002.png"
    },
    {
        "category": "fast food",
        "title": "Cheeseburger",
        "description": "A cheeseburger is a classic fast-food sandwich made with a beef patty, melted cheese, and fresh toppings like tomato and pickles.",
        "ingredients": [
            "bun",
            "beef patty",
            "cheese",
            "tomato",
            "pickle",
            "lettuce"
        ],
        "protein": 12.0,
        "fats": 14.0,
        "carbohydrates": 28.0,
        "fiber": 1.5,
        "image_url": "assets/images/0008.png"
    },
    {
        "category": "salad",
        "title": "Greek Salad",
        "description": "Greek salad is a refreshing mix of vegetables like cucumber and tomatoes, topped with feta cheese and olives.",
        "ingredients": [
            "spinach",
            "cucumber",
            "olive",
            "feta cheese",
            "cherry tomato"
        ],
        "protein": 2.5,
        "fats": 4.5,
        "carbohydrates": 3.5,
        "fiber": 2.0,
        "image_url": "assets/images/0009.png"
    },
    {
        "category": "fruit",
        "title": "Kiwis",
        "description": "Kiwis are small, green-fleshed fruits with a sweet and slightly tangy taste, packed with vitamin C and fiber.",
        "ingredients": [
            "kiwi"
        ],
        "protein": 1.1,
        "fats": 0.5,
        "carbohydrates": 14.0,
        "fiber": 3.0,
        "image_url": "assets/images/0010.png"
    },
    {
        "category": "snack",
        "title": "Rice Cakes",
        "description": "Rice cakes are light, crispy snacks made from puffed rice, often enjoyed as a low-calorie option.",
        "ingredients": [
            "rice"
        ],
        "protein": 2.4,
        "fats": 0.2,
        "carbohydrates": 83.0,
        "fiber": 3.0,
        "image_url": "assets/images/0012.png"
    },
    {
        "category": "salad",
        "title": "Pickled Salad",
        "description": "Pickled salad combines crunchy vegetables with a tangy pickle flavor, making it a refreshing side dish.",
        "ingredients": [
            "lettuce",
            "pickle",
            "cherry tomato",
            "pearl onion"
        ],
        "protein": 1.0,
        "fats": 0.1,
        "carbohydrates": 4.0,
        "fiber": 1.5,
        "image_url": "assets/images/0013.png"
    },
    {
        "category": "pastries",
        "title": "Apple Pastries",
        "description": "Apple pastries are flaky, baked treats filled with sweetened apple pieces, offering a warm, fruity flavor.",
        "ingredients": [
            "pastry dough",
            "apple filling"
        ],
        "protein": 2.0,
        "fats": 8.0,
        "carbohydrates": 35.0,
        "fiber": 1.0,
        "image_url": "assets/images/0014.png"
    },
    {
        "category": "dessert",
        "title": "Chocolate Sticks",
        "description": "Chocolate sticks are rich, dark chocolate bars or sticks, offering an indulgent and slightly bitter taste.",
        "ingredients": [
            "dark chocolate"
        ],
        "protein": 5.4,
        "fats": 30.0,
        "carbohydrates": 58.0,
        "fiber": 7.0,
        "image_url": "assets/images/0015.png"
    },
    {
        "category": "snack",
        "title": "Macadamia Nuts",
        "description": "Macadamia nuts are creamy and buttery nuts, known for their rich flavor and high healthy fat content.",
        "ingredients": [
            "macadamia nuts"
        ],
        "protein": 7.9,
        "fats": 75.8,
        "carbohydrates": 13.8,
        "fiber": 8.6,
        "image_url": "assets/images/0016.png"
    },
    {
        "category": "salad",
        "title": "Waldorf Salad",
        "description": "Waldorf Salad is a classic salad made with crisp lettuce, sweet apples, crunchy celery, walnuts, and raisins, dressed in a light, creamy sauce.",
        "ingredients": [
            "lettuce",
            "apple",
            "celery",
            "walnut",
            "raisin"
        ],
        "protein": 1.5,
        "fats": 5.0,
        "carbohydrates": 8.5,
        "fiber": 2.0,
        "image_url": "assets/images/0020.png"
    },
    {
        "category": "dessert",
        "title": "Stroopwafels",
        "description": "Stroopwafels are traditional Dutch treats made of two thin waffles with a gooey caramel syrup filling in between.",
        "ingredients": [
            "flour",
            "butter",
            "sugar",
            "caramel"
        ],
        "protein": 2.5,
        "fats": 11.0,
        "carbohydrates": 63.0,
        "fiber": 1.0,
        "image_url": "assets/images/0021.png"
    },
    {
        "category": "snack",
        "title": "Almonds",
        "description": "Almonds are crunchy, nutrient-dense nuts rich in healthy fats, protein, and fiber, commonly enjoyed as a healthy snack.",
        "ingredients": [
            "almonds"
        ],
        "protein": 21.2,
        "fats": 49.9,
        "carbohydrates": 21.6,
        "fiber": 12.5,
        "image_url": "assets/images/0023.png"
    },
    {
        "category": "fruit",
        "title": "Blueberries",
        "description": "Blueberries are small, juicy berries with a sweet-tart flavor, known for their high antioxidant content.",
        "ingredients": [
            "blueberries"
        ],
        "protein": 0.7,
        "fats": 0.3,
        "carbohydrates": 14.5,
        "fiber": 2.4,
        "image_url": "assets/images/0025.png"
    },
    {
        "category": "snack",
        "title": "Cashews",
        "description": "Cashews are creamy, slightly sweet nuts, often enjoyed roasted and salted as a satisfying snack.",
        "ingredients": [
            "cashews"
        ],
        "protein": 18.2,
        "fats": 43.9,
        "carbohydrates": 30.2,
        "fiber": 3.3,
        "image_url": "assets/images/0029.png"
    },
    {
        "category": "snack",
        "title": "Tortilla Chips",
        "description": "Tortilla chips are crunchy, corn-based snacks often served with salsa or guacamole as a popular party appetizer.",
        "ingredients": [
            "corn",
            "vegetable oil",
            "salt"
        ],
        "protein": 6.0,
        "fats": 23.0,
        "carbohydrates": 61.0,
        "fiber": 5.5,
        "image_url": "assets/images/0030.png"
    },
    {
        "category": "snack",
        "title": "Potato Chips",
        "description": "Potato chips are thinly sliced, deep-fried potatoes that are crispy, salty, and enjoyed as a popular snack worldwide.",
        "ingredients": [
            "potato",
            "vegetable oil",
            "salt"
        ],
        "protein": 6.5,
        "fats": 35.0,
        "carbohydrates": 53.0,
        "fiber": 4.0,
        "image_url": "assets/images/0031.png"
    },
    {
        "category": "dessert",
        "title": "Chocolate Donuts",
        "description": "Chocolate donuts are sweet, deep-fried pastries topped with a rich chocolate glaze, perfect for dessert or a treat with coffee.",
        "ingredients": [
            "flour",
            "sugar",
            "cocoa",
            "chocolate glaze"
        ],
        "protein": 4.0,
        "fats": 15.0,
        "carbohydrates": 48.0,
        "fiber": 1.5,
        "image_url": "assets/images/0032.png"
    },
    {
        "category": "vegetable",
        "title": "Cucumber",
        "description": "Cucumbers are cool, refreshing vegetables with a high water content, commonly used in salads and snacks.",
        "ingredients": [
            "cucumber"
        ],
        "protein": 0.6,
        "fats": 0.1,
        "carbohydrates": 3.6,
        "fiber": 0.5,
        "image_url": "assets/images/0033.png"
    },
    {
        "category": "breakfast",
        "title": "Fried Egg on Toast",
        "description": "Fried egg on toast is a simple breakfast dish with fried eggs served over toasted bread, often topped with butter or seasoning.",
        "ingredients": [
            "bread",
            "egg",
            "butter"
        ],
        "protein": 6.5,
        "fats": 9.0,
        "carbohydrates": 22.0,
        "fiber": 1.5,
        "image_url": "assets/images/0037.png"
    },
    {
        "category": "fruit",
        "title": "Raspberries",
        "description": "Raspberries are vibrant, sweet-tart berries, enjoyed fresh or used in desserts, smoothies, and salads.",
        "ingredients": [
            "raspberries"
        ],
        "protein": 1.2,
        "fats": 0.6,
        "carbohydrates": 12.0,
        "fiber": 6.5,
        "image_url": "assets/images/0038.png"
    },
    {
        "category": "fruit",
        "title": "Pineapple Rings",
        "description": "Pineapple rings are juicy, tropical slices perfect for adding a burst of sweetness to dishes or enjoyed on their own.",
        "ingredients": [
            "pineapple"
        ],
        "protein": 0.5,
        "fats": 0.1,
        "carbohydrates": 13.1,
        "fiber": 1.4,
        "image_url": "assets/images/0044.png"
    },
    {
        "category": "snack",
        "title": "Pistachios",
        "description": "Pistachios are nutrient-rich nuts with a unique, slightly sweet flavor, often enjoyed as a wholesome snack.",
        "ingredients": [
            "pistachios"
        ],
        "protein": 20.6,
        "fats": 45.8,
        "carbohydrates": 27.0,
        "fiber": 10.3,
        "image_url": "assets/images/0048.png"
    },
    {
        "category": "sandwich",
        "title": "Deli Sandwiches",
        "description": "These deli sandwiches feature whole grain bread filled with turkey, salami, and crisp lettuce for a satisfying meal.",
        "ingredients": [
            "whole grain bread",
            "turkey",
            "salami",
            "lettuce"
        ],
        "protein": 12.0,
        "fats": 6.0,
        "carbohydrates": 35.0,
        "fiber": 3.0,
        "image_url": "assets/images/0049.png"
    },
    {
        "category": "vegetable",
        "title": "Tomatoes",
        "description": "Tomatoes are juicy and flavorful, often used fresh in salads, sauces, and a variety of dishes.",
        "ingredients": [
            "tomato"
        ],
        "protein": 0.9,
        "fats": 0.2,
        "carbohydrates": 3.9,
        "fiber": 1.2,
        "image_url": "assets/images/0054.png"
    },
    {
        "category": "salad",
        "title": "Cucumber Tomato Salad",
        "description": "A refreshing salad made with diced cucumbers and tomatoes, perfect for a light, hydrating dish.",
        "ingredients": [
            "cucumber",
            "tomato"
        ],
        "protein": 0.8,
        "fats": 0.1,
        "carbohydrates": 4.0,
        "fiber": 1.2,
        "image_url": "assets/images/0055.png"
    },
    {
        "category": "snack",
        "title": "Walnuts",
        "description": "Walnuts are rich, crunchy nuts known for their high omega-3 content and used in various sweet and savory recipes.",
        "ingredients": [
            "walnuts"
        ],
        "protein": 15.2,
        "fats": 65.2,
        "carbohydrates": 13.7,
        "fiber": 6.7,
        "image_url": "assets/images/0057.png"
    },
    {
        "category": "breakfast",
        "title": "Bacon Pancake",
        "description": "A hearty breakfast option, this pancake is topped with crispy bacon strips for a savory twist.",
        "ingredients": [
            "flour",
            "egg",
            "milk",
            "bacon"
        ],
        "protein": 6.5,
        "fats": 8.5,
        "carbohydrates": 22.0,
        "fiber": 0.5,
        "image_url": "assets/images/0060.png"
    },
    {
        "category": "vegetable",
        "title": "Mushrooms",
        "description": "White mushrooms are mild and versatile, often used fresh in salads or cooked in a variety of dishes.",
        "ingredients": [
            "mushrooms"
        ],
        "protein": 3.1,
        "fats": 0.3,
        "carbohydrates": 3.3,
        "fiber": 1.0,
        "image_url": "assets/images/0063.png"
    },
    {
        "category": "fruit",
        "title": "Bananas",
        "description": "Bananas are sweet, soft fruits that provide a quick energy boost and are enjoyed fresh or in baked goods.",
        "ingredients": [
            "banana"
        ],
        "protein": 1.3,
        "fats": 0.3,
        "carbohydrates": 22.8,
        "fiber": 2.6,
        "image_url": "assets/images/0066.png"
    },
    {
        "category": "fruit",
        "title": "Pears",
        "description": "Pears are sweet, juicy fruits with a soft texture, enjoyed fresh or used in desserts and salads.",
        "ingredients": [
            "pears"
        ],
        "protein": 0.4,
        "fats": 0.1,
        "carbohydrates": 15.0,
        "fiber": 3.1,
        "image_url": "assets/images/0072.png"
    },
    {
        "category": "vegetable",
        "title": "Potatoes",
        "description": "Potatoes are versatile root vegetables, commonly baked, fried, or mashed in a variety of dishes.",
        "ingredients": [
            "potatoes"
        ],
        "protein": 2.0,
        "fats": 0.1,
        "carbohydrates": 17.0,
        "fiber": 2.2,
        "image_url": "assets/images/0075.png"
    },
    {
        "category": "salad",
        "title": "Salmon Salad",
        "description": "Salmon salad combines mixed greens and tender salmon with a creamy dressing, offering a nutritious and flavorful meal.",
        "ingredients": [
            "mixed greens",
            "salmon",
            "dressing"
        ],
        "protein": 6.0,
        "fats": 5.0,
        "carbohydrates": 2.0,
        "fiber": 1.5,
        "image_url": "assets/images/0078.png"
    },
    {
        "category": "salad",
        "title": "Egg and Greens Salad",
        "description": "This salad features mixed greens topped with chopped eggs and a sprinkle of sesame seeds, creating a hearty and nutritious dish.",
        "ingredients": [
            "greens",
            "egg",
            "sesame seeds"
        ],
        "protein": 5.0,
        "fats": 6.0,
        "carbohydrates": 2.5,
        "fiber": 1.0,
        "image_url": "assets/images/0079.png"
    },
    {
        "category": "dessert",
        "title": "Apple Pie",
        "description": "Apple pie is a beloved dessert with a flaky crust and a spiced apple filling, served warm and often with ice cream.",
        "ingredients": [
            "apple",
            "flour",
            "butter",
            "sugar"
        ],
        "protein": 1.5,
        "fats": 10.0,
        "carbohydrates": 30.0,
        "fiber": 2.0,
        "image_url": "assets/images/0083.png"
    },
    {
        "category": "protein",
        "title": "Eggs",
        "description": "Eggs are a versatile protein source, often cooked in various ways such as scrambled, fried, or boiled.",
        "ingredients": [
            "eggs"
        ],
        "protein": 13.0,
        "fats": 10.0,
        "carbohydrates": 1.1,
        "fiber": 0.0,
        "image_url": "assets/images/0091.png"
    },
    {
        "category": "wrap",
        "title": "Shawarma",
        "description": "Shawarma is a popular wrap filled with seasoned meat, fresh tomatoes, and a creamy sauce, wrapped in flatbread.",
        "ingredients": [
            "flatbread",
            "meat",
            "tomato",
            "sauce"
        ],
        "protein": 10.0,
        "fats": 8.0,
        "carbohydrates": 24.0,
        "fiber": 2.5,
        "image_url": "assets/images/0117.png"
    },
    {
        "category": "snack",
        "title": "Chocolate Sandwich Cookies",
        "description": "Chocolate sandwich cookies feature a creamy filling between two chocolate cookie layers, making them a popular sweet treat.",
        "ingredients": [
            "chocolate cookies",
            "cream filling"
        ],
        "protein": 2.5,
        "fats": 20.0,
        "carbohydrates": 60.0,
        "fiber": 3.0,
        "image_url": "assets/images/0155.png"
    },
    {
        "category": "snack",
        "title": "Oatmeal Cookies",
        "description": "Oatmeal cookies are soft, chewy treats made from oats, providing a balance of sweetness and hearty texture.",
        "ingredients": [
            "oats",
            "flour",
            "butter",
            "sugar"
        ],
        "protein": 5.0,
        "fats": 15.0,
        "carbohydrates": 60.0,
        "fiber": 5.0,
        "image_url": "assets/images/0158.png"
    },
    {
        "category": "dessert",
        "title": "Chocolate Muffins",
        "description": "Chocolate muffins are rich, moist treats often topped with nuts, making for a delicious dessert or snack.",
        "ingredients": [
            "chocolate",
            "flour",
            "sugar",
            "nuts"
        ],
        "protein": 6.0,
        "fats": 22.0,
        "carbohydrates": 55.0,
        "fiber": 2.0,
        "image_url": "assets/images/0243.png"
    },
    {
        "category": "French Fries",
        "title": "French Fries",
        "description": "French fries are crispy, golden sticks of fried potato, seasoned with salt and often enjoyed with ketchup or dipping sauces.",
        "ingredients": [
            "potatoes",
            "salt",
            "oil"
        ],
        "protein": 3.5,
        "fats": 15.0,
        "carbohydrates": 35.0,
        "fiber": 3.0,
        "image_url": "assets/images/0289.png"
    },
    {
        "category": "Nuggets",
        "title": "Chicken Nuggets",
        "description": "Chicken nuggets are small pieces of breaded and fried chicken, making a popular snack or meal option.",
        "ingredients": [
            "chicken breast",
            "flour",
            "breadcrumbs",
            "oil",
            "salt"
        ],
        "protein": 18.0,
        "fats": 13.0,
        "carbohydrates": 14.0,
        "fiber": 1.5,
        "image_url": "assets/images/0293.png"
    },
    {
        "category": "Wrap",
        "title": "Chicken Wrap",
        "description": "A chicken wrap combines grilled chicken, lettuce, and creamy dressing in a soft tortilla for a satisfying meal.",
        "ingredients": [
            "tortilla",
            "chicken breast",
            "lettuce",
            "mayonnaise"
        ],
        "protein": 10.0,
        "fats": 8.0,
        "carbohydrates": 25.0,
        "fiber": 3.0,
        "image_url": "assets/images/0294.png"
    },
    {
        "category": "Pastry",
        "title": "Croissants",
        "description": "Croissants are light and flaky pastries with a buttery flavor, perfect as a breakfast treat or snack.",
        "ingredients": [
            "flour",
            "butter",
            "milk",
            "sugar",
            "salt"
        ],
        "protein": 6.0,
        "fats": 22.0,
        "carbohydrates": 45.0,
        "fiber": 1.5,
        "image_url": "assets/images/0301.png"
    },
    {
        "category": "Cookies",
        "title": "Chocolate Chip Cookies",
        "description": "Chocolate chip cookies are soft, chewy treats with chocolate pieces throughout, loved as a classic dessert.",
        "ingredients": [
            "flour",
            "butter",
            "sugar",
            "chocolate chips",
            "eggs"
        ],
        "protein": 5.0,
        "fats": 20.0,
        "carbohydrates": 60.0,
        "fiber": 2.0,
        "image_url": "assets/images/0328.png"
    },
    {
        "category": "Italian",
        "title": "Margherita Pizza",
        "description": "Margherita pizza is a classic Italian dish topped with tomato sauce, fresh mozzarella, and basil leaves.",
        "ingredients": [
            "pizza dough",
            "tomato sauce",
            "mozzarella",
            "basil"
        ],
        "protein": 10.0,
        "fats": 8.0,
        "carbohydrates": 30.0,
        "fiber": 2.5,
        "image_url": "assets/images/0357.png"
    },
    {
        "category": "Japanese",
        "title": "Maki Sushi Rolls",
        "description": "Maki sushi rolls are a Japanese delicacy with rice, vegetables, and egg, wrapped in seaweed.",
        "ingredients": [
            "rice",
            "egg",
            "cucumber",
            "seaweed",
            "carrot"
        ],
        "protein": 7.0,
        "fats": 2.5,
        "carbohydrates": 20.0,
        "fiber": 1.5,
        "image_url": "assets/images/0374.png"
    },
    {
        "category": "Japanese",
        "title": "Onigiri",
        "description": "Onigiri, or rice balls, are Japanese snacks with rice and a filling, often wrapped in seaweed.",
        "ingredients": [
            "rice",
            "salmon",
            "seaweed",
            "salt"
        ],
        "protein": 6.5,
        "fats": 2.0,
        "carbohydrates": 25.0,
        "fiber": 1.0,
        "image_url": "assets/images/0427.png"
    },
    {
        "category": "Asian",
        "title": "Steamed Buns",
        "description": "Steamed buns are soft, fluffy rolls filled with savory pork and seasonings, enjoyed as a popular Asian snack.",
        "ingredients": [
            "flour",
            "yeast",
            "pork",
            "soy sauce"
        ],
        "protein": 8.0,
        "fats": 3.5,
        "carbohydrates": 30.0,
        "fiber": 1.5,
        "image_url": "assets/images/0458.png"
    },
    {
        "category": "Japanese",
        "title": "Japanese Curry with Rice",
        "description": "Japanese curry is a hearty, mildly spicy dish served over rice, often with vegetables and meat.",
        "ingredients": [
            "rice",
            "potatoes",
            "carrots",
            "beef",
            "curry roux"
        ],
        "protein": 9.0,
        "fats": 6.0,
        "carbohydrates": 40.0,
        "fiber": 3.5,
        "image_url": "assets/images/0527.png"
    }
]
''';

List<Map<String, dynamic>> mealPlan = [
  {
    "day": "Sun",
    "date": "24",
    "meals": [
      {
        "category": "Breakfast",
        "title": "Fried Egg on Toast",
        "calories": 180,
        "imageUrl": "assets/images/0037.png",
        "isConsumed": false
      },
      {
        "category": "Snack",
        "title": "Oranges",
        "calories": 62,
        "imageUrl": "assets/images/0001.png",
        "isConsumed": false
      },
      {
        "category": "Lunch",
        "title": "Greek Salad",
        "calories": 120,
        "imageUrl": "assets/images/0009.png",
        "isConsumed": false
      },
      {
        "category": "Dinner",
        "title": "Cheeseburger",
        "calories": 350,
        "imageUrl": "assets/images/0008.png",
        "isConsumed": false
      },
      {
        "category": "Dessert",
        "title": "Chocolate Donuts",
        "calories": 290,
        "imageUrl": "assets/images/0032.png",
        "isConsumed": false
      },
    ],
  },
  {
    "day": "Mon",
    "date": "25",
    "meals": [
      {
        "category": "Breakfast",
        "title": "Bacon Pancake",
        "calories": 250,
        "imageUrl": "assets/images/0060.png",
        "isConsumed": false
      },
      {
        "category": "Snack",
        "title": "Almonds",
        "calories": 160,
        "imageUrl": "assets/images/0023.png",
        "isConsumed": false
      },
      {
        "category": "Lunch",
        "title": "Pickled Salad",
        "calories": 70,
        "imageUrl": "assets/images/0013.png",
        "isConsumed": false
      },
      {
        "category": "Dinner",
        "title": "Deli Sandwiches",
        "calories": 400,
        "imageUrl": "assets/images/0049.png",
        "isConsumed": false
      },
      {
        "category": "Dessert",
        "title": "Stroopwafels",
        "calories": 210,
        "imageUrl": "assets/images/0021.png",
        "isConsumed": false
      },
    ],
  },
  {
    "day": "Tue",
    "date": "26",
    "meals": [
      {
        "category": "Breakfast",
        "title": "Apple Pastries",
        "calories": 220,
        "imageUrl": "assets/images/0014.png",
        "isConsumed": false
      },
      {
        "category": "Snack",
        "title": "Macadamia Nuts",
        "calories": 200,
        "imageUrl": "assets/images/0016.png",
        "isConsumed": false
      },
      {
        "category": "Lunch",
        "title": "Waldorf Salad",
        "calories": 180,
        "imageUrl": "assets/images/0020.png",
        "isConsumed": false
      },
      {
        "category": "Dinner",
        "title": "Salmon Salad",
        "calories": 240,
        "imageUrl": "assets/images/0078.png",
        "isConsumed": false
      },
      {
        "category": "Dessert",
        "title": "Chocolate Sticks",
        "calories": 250,
        "imageUrl": "assets/images/0015.png",
        "isConsumed": false
      },
    ],
  },
  {
    "day": "Wed",
    "date": "27",
    "meals": [
      {
        "category": "Breakfast",
        "title": "Fried Egg on Toast",
        "calories": 180,
        "imageUrl": "assets/images/0037.png",
        "isConsumed": false
      },
      {
        "category": "Snack",
        "title": "Blueberries",
        "calories": 85,
        "imageUrl": "assets/images/0025.png",
        "isConsumed": false
      },
      {
        "category": "Lunch",
        "title": "Egg and Greens Salad",
        "calories": 150,
        "imageUrl": "assets/images/0079.png",
        "isConsumed": false
      },
      {
        "category": "Dinner",
        "title": "Cheeseburger",
        "calories": 350,
        "imageUrl": "assets/images/0008.png",
        "isConsumed": false
      },
      {
        "category": "Dessert",
        "title": "Apple Pie",
        "calories": 300,
        "imageUrl": "assets/images/0014.png",
        "isConsumed": false
      },
    ],
  },
  {
    "day": "Thu",
    "date": "28",
    "meals": [
      {
        "category": "Breakfast",
        "title": "Bacon Pancake",
        "calories": 250,
        "imageUrl": "assets/images/0060.png",
        "isConsumed": false
      },
      {
        "category": "Snack",
        "title": "Cashews",
        "calories": 155,
        "imageUrl": "assets/images/0029.png",
        "isConsumed": false
      },
      {
        "category": "Lunch",
        "title": "Cucumber Tomato Salad",
        "calories": 90,
        "imageUrl": "assets/images/0055.png",
        "isConsumed": false
      },
      {
        "category": "Dinner",
        "title": "Salmon Salad",
        "calories": 240,
        "imageUrl": "assets/images/0078.png",
        "isConsumed": false
      },
      {
        "category": "Dessert",
        "title": "Stroopwafels",
        "calories": 210,
        "imageUrl": "assets/images/0021.png",
        "isConsumed": false
      },
    ],
  },
  {
    "day": "Fri",
    "date": "29",
    "meals": [
      {
        "category": "Breakfast",
        "title": "Fried Egg on Toast",
        "calories": 180,
        "imageUrl": "assets/images/0037.png",
        "isConsumed": false
      },
      {
        "category": "Snack",
        "title": "Pistachios",
        "calories": 160,
        "imageUrl": "assets/images/0048.png",
        "isConsumed": false
      },
      {
        "category": "Lunch",
        "title": "Waldorf Salad",
        "calories": 180,
        "imageUrl": "assets/images/0020.png",
        "isConsumed": false
      },
      {
        "category": "Dinner",
        "title": "Deli Sandwiches",
        "calories": 400,
        "imageUrl": "assets/images/0049.png",
        "isConsumed": false
      },
      {
        "category": "Dessert",
        "title": "Chocolate Donuts",
        "calories": 290,
        "imageUrl": "assets/images/0032.png",
        "isConsumed": false
      },
    ],
  },
  {
    "day": "Sat",
    "date": "30",
    "meals": [
      {
        "category": "Breakfast",
        "title": "Apple Pastries",
        "calories": 220,
        "imageUrl": "assets/images/0014.png",
        "isConsumed": false
      },
      {
        "category": "Snack",
        "title": "Walnuts",
        "calories": 160,
        "imageUrl": "assets/images/0057.png",
        "isConsumed": false
      },
      {
        "category": "Lunch",
        "title": "Greek Salad",
        "calories": 120,
        "imageUrl": "assets/images/0009.png",
        "isConsumed": false
      },
      {
        "category": "Dinner",
        "title": "Cheeseburger",
        "calories": 350,
        "imageUrl": "assets/images/0008.png",
        "isConsumed": false
      },
      {
        "category": "Dessert",
        "title": "Apple Pie",
        "calories": 300,
        "imageUrl": "assets/images/0014.png",
        "isConsumed": false
      },
    ],
  },
];

// Parse JSON data and convert it to a list of FoodItems
List<FoodItem> parseFoodItems(String jsonData) {
  final data = json.decode(jsonData) as List;
  return data.map((json) => FoodItem.fromJson(json)).toList();
}

final List<FoodItem> foodItems = parseFoodItems(jsonData);
