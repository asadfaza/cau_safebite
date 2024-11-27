import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:cau_safebite/welcome_pages/options.dart';
import 'package:cau_safebite/welcome_pages/waiting_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  final int index;

  const WelcomePage({
    required this.index,
    Key? key,
  }) : super(key: key);


  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isReady = false;
  int _currentIndex = 0;
  int calculatedAge = 0;
  String selectedGender = 'Male';
  String selectedReligious = 'Islam';
  List<String> selectedOptionsDiet = ["I eat everything"];
  List<String> selectedAllergies = [];
  List<String> selectedDiseases = [];
  void toggleSelection(String option, List<String> selectedOptions) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = widget.index;
    _controller = PageController(initialPage: _currentIndex);
    super.initState();
  }

  late PageController _controller;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
            body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            firstPage(screenSize),
            secondPage(screenSize),
            thirdPage(screenSize),
            fourthPage(screenSize),
            fifthPage(screenSize),
            sixthPage(screenSize)
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: screenSize.width * 0.09,
                height: 4,
                decoration: BoxDecoration(
                  color: index <= _currentIndex ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: screenSize.width * 0.1, right: screenSize.width * 0.1),
          margin: EdgeInsets.only(bottom: 30),
          alignment: Alignment.bottomCenter,
          child: TextButton(
              style: buttonStyle(screenSize.width, Color(0xffA3CFF3)),
              onPressed: () {
                if (_currentIndex == 5) {
                  showSaveConfirmationDialog(context);
                } else {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                }
              },
              child: Text((_currentIndex == 5) ? 'Save' : 'Next')),
        )
      ],
    )));
  }

  Widget firstPage(Size screenSize) => Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    foodItem('Breakfast', 'Toast with Eggs', '210',
                        Color(0xffE9F5E0), screenSize),
                    SizedBox(
                      height: 30,
                    ),
                    foodItem('Lunch', 'Grilled Chicken', '350',
                        Color(0xffF5EEE0), screenSize),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    foodItem('Snack', 'Fruit Salad', '80', Color(0xffF5E0E0),
                        screenSize),
                    SizedBox(
                      height: 30,
                    ),
                    foodItem('Dinner', 'Spaghetti', '600', Color(0xffE0F5F4),
                        screenSize),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Text(
                  'Better Choice',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Container(
                  width: 200,
                  child: Text(
                    'Discover better way of living',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Text(
                  'With our ',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                ),
                Text(
                  'Personalized',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Container(
                  width: 200,
                  child: Text(
                    'meal plans',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  Widget secondPage(Size screenSize) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.1),
                    Text(
                      'Better Life',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.1),
                    Text(
                      'Unlock your potential',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.1),
                    Text(
                      'With our ',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                    ),
                    Text(
                      'Advanced',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.1),
                    Text(
                      'Methods in AI',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 300,
              child: Image.asset('assets/egg_image.png'),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      );
  Widget thirdPage(Size screenSize) => Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_box),
              SizedBox(
                width: 10,
              ),
              Text(
                'Build a better Tomorrow',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  Text(
                    'Better Future',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  Text(
                    'Build a better',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  Text(
                    'Tomorrow',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  Text(
                    'With ',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                  ),
                  Text(
                    'Safebite',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ));

  Widget fourthPage(Size screenSize) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  Text(
                    'What is your age?',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 23,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  Text(
                    'Set your birth date',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  Container(
                    width: screenSize.width * 0.7,
                    child: Text(
                      'We need this info for more specific recommendations',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) => setState(() {
                selectedDate = newTime;
              }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
  Widget fifthPage(Size screenSize) => Container(
        padding: EdgeInsets.only(
            top: 70,
            left: screenSize.width * 0.1,
            right: screenSize.width * 0.1),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'What is your gender?',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 23,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Male/Female',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: screenSize.width * 0.7,
                  child: Text(
                    'We need this info for more specific recommendations',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: options(genderOptions, gIconOptions, selectedGender))
          ],
        ),
      );
  Widget sixthPage(Size screenSize) => Container(
        padding: EdgeInsets.only(
            top: 70,
            left: screenSize.width * 0.08,
            right: screenSize.width * 0.08),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Do you follow specific diet?',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 21,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Allergies, Diseases, Religious',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: screenSize.width * 0.7,
                  child: Text(
                    'You can choose more than 1 answer',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: options(dietOptions, dIconOptions, selectedOptionsDiet))
          ],
        ),
      );

  Widget foodItem(String title, String subtitle, String calories, Color color,
          Size size) =>
      Container(
          height: 80,
          width: size.width * 0.4,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            isThreeLine: true,
            title: Text(title),
            titleTextStyle:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
            subtitleTextStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: Colors.black),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(subtitle),
                SizedBox(height: 5),
                Text('$calories kcal')
              ],
            ),
          ));

  Widget options(
          List<String> options, List<Widget> imageOptions, selectedOptions) =>
      ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return GestureDetector(
            onTap: () async {
              if (selectedOptions == selectedGender) {
                setState(() {
                  selectedGender = option;
                });
              } else if (selectedOptions == selectedOptionsDiet) {
                if (option == 'Allergies' &&
                    !selectedOptions.contains("Allergies")) {
                  if (selectedOptions.contains("I eat everything")) {
                    selectedOptions.remove("I eat everything");
                  }
                  toggleSelection(option, selectedOptions);
                  List<String> updatedOptions = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageForChoose(
                              title: 'Allergies',
                              center: Container(),
                              options: allergies,
                              isReligious: false,
                            )),
                  );
                  if (updatedOptions.isNotEmpty) {
                    setState(() {
                      selectedAllergies = updatedOptions;
                    });
                  }
                } else if (option == 'Diseases' &&
                    !selectedOptions.contains("Diseases")) {
                  if (selectedOptions.contains("I eat everything")) {
                    selectedOptions.remove("I eat everything");
                  }
                  toggleSelection(option, selectedOptions);
                  List<String> updatedOptions = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageForChoose(
                              title: 'Diseases',
                              center: Container(),
                              options: diseases,
                              isReligious: false,
                            )),
                  );
                  if (updatedOptions.isNotEmpty) {
                    setState(() {
                      selectedDiseases = updatedOptions;
                    });
                  }
                } else if (option == 'Religious' &&
                    !selectedOptions.contains("Religious")) {
                  if (selectedOptions.contains("I eat everything")) {
                    selectedOptions.remove("I eat everything");
                  }
                  toggleSelection(option, selectedOptions);
                  String selected = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageForChoose(
                              title: 'Religious',
                              center: Container(),
                              options: religiousOptions,
                              isReligious: true,
                            )),
                  );
                  if (selected.isNotEmpty) {
                    setState(() {
                      selectedReligious = selected;
                    });
                  }
                } else if (selectedOptions.isNotEmpty) {
                  if (selectedOptions.contains("I eat everything")) {
                    selectedOptions.remove("I eat everything");
                    toggleSelection(option, selectedOptions);
                  } else {
                    toggleSelection(option, selectedOptions);
                  }
                } else {
                  toggleSelection(option, selectedOptions);
                }
              } else {
                toggleSelection(option, selectedOptions);
              }
            },
            child: Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: (selectedOptions == selectedGender)
                      ? selectedGender == option
                          ? Colors.blue.shade300
                          : Colors.grey.shade300
                      : selectedOptions.contains(option)
                          ? Colors.blue.shade300
                          : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5),
                      imageOptions[index],
                      SizedBox(width: 10),
                      Text(
                        option,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  if (["Religious", "Allergies", "Diseases"].contains(option))
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      );
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

  void showSaveConfirmationDialog(BuildContext context) {
    calculateAge(selectedDate);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Save"),
          content: Container(
            height: 80,
            child: Column(
              children: [
                Text('$selectedGender, Religious: $selectedReligious'),
                Text("$calculatedAge years old"),
                Text("Diet specifications:"),
                Wrap(
                  children: selectedOptionsDiet
                      .map((option) => Text('$option '))
                      .toList(),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle Cancel action
                Navigator.of(context).pop();

                print("User chose not to save.");
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle Save action
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WaitingWidget(
                          religious: selectedReligious,
                          selectedAllergies: selectedAllergies,
                          selectedDate: selectedDate,
                          selectedDiets: selectedOptionsDiet,
                          selectedDiseases: selectedDiseases,
                          gender: selectedGender)),
                );
                print("User chose to save.");
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}



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
  'celiac disease',
  'lactose intolerance',
  'diabetes',
  'heart Disease',
  'hypertension (high blood pressure)',
  'irritable bowel syndrome (IBS)',
  'gout',
  'kidney disease',
  'anemia (Iron Deficiency)'
];

final List<String> religiousOptions = [
    "Christianity",
    "Islam",
    "Judaism",
    "Buddhist",
    "Hindu",
  ];

  final List<String> genderOptions = [
    "Male",
    "Female",
  ];
  List<Widget> gIconOptions = [
    Image.asset(
      'assets/options/male.png',
      width: 40,
      height: 40,
    ),
    Image.asset(
      'assets/options/female.png',
      width: 40,
      height: 40,
    )
  ];
  final List<String> dietOptions = [
    "I eat everything",
    "Religious",
    "Allergies",
    "Diseases",
    "Vegan",
    "Vegetarian",
  ];
  List<Widget> dIconOptions = [
    Icon(
      Icons.check_circle,
      color: Colors.blue,
    ),
    Image.asset(
      'assets/options/religious.png',
      width: 40,
      height: 40,
    ),
    Image.asset(
      'assets/options/allergies.png',
      width: 40,
      height: 40,
    ),
    Image.asset(
      'assets/options/diseases.png',
      width: 40,
      height: 40,
    ),
    Image.asset(
      'assets/options/vegan.png',
      width: 40,
      height: 40,
    ),
    Image.asset(
      'assets/options/vegeterian.png',
      width: 40,
      height: 40,
    ),
  ];