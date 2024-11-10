import 'package:cau_safebite/auth/auth.dart';
import 'package:cau_safebite/auth/login_page.dart';
import 'package:cau_safebite/auth/sign_in_page.dart';
import 'package:cau_safebite/firebase_options.dart';
import 'package:cau_safebite/pages/dietary_plan.dart';
import 'package:cau_safebite/pages/favorite.dart';
import 'package:cau_safebite/pages/home_page.dart';
import 'package:cau_safebite/pages/profile.dart';
import 'package:cau_safebite/welcome_pages/customize.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    initialRoute: '/auth',
    routes: {
      '/': (context) => const MyApp(),
      '/custom': (context) => const AllergySelectionScreen(),
      '/auth': (context) => const AuthCheck(),
      '/homePage': (context) => const HomePage(),
      '/favorite': (context) => MealPlanPage(),
      '/login': (contex) => const Login(),
      '/sign_up': (context) => const SignUp(),
      '/profile': (context) => const ProfileScreen()
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final tabs = [HomePage(), MealPlanPage(), DietaryPlan(), ProfileScreen()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 25,
            onTap: (index) async {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            unselectedFontSize: 11,
            selectedFontSize: 11,
            selectedLabelStyle:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            elevation: 0,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset((_currentIndex == 0)
                    ? 'assets/home.svg'
                    : 'assets/home_outlined.svg'),
                label: 'home',
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset((_currentIndex == 1)
                      ? 'assets/my_plan.svg'
                      : 'assets/my_plan_outlined.svg'),
                  label: 'my plan'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset((_currentIndex == 2)
                      ? 'assets/my_list.svg'
                      : 'assets/my_list_outlined.svg'),
                  label: 'my list'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset((_currentIndex == 3)
                      ? 'assets/profile.svg'
                      : 'assets/profile_outlined.svg'),
                  label: 'profile'),
            ]),
      ),
    );
  }
}
