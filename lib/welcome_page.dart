import 'package:cau_safebite/auth/login_page.dart';
import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Welcome_page extends StatefulWidget {
  const Welcome_page({super.key});

  @override
  State<Welcome_page> createState() => _Welcome_pageState();
}

class _Welcome_pageState extends State<Welcome_page> {
  bool isReady = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          ImageSlideshow(
              height: screenSize.height,
              onPageChanged: (value) {
                if (value == 2) {
                  setState(() {
                    isReady = true;
                  });
                } else {
                  setState(() {
                    isReady = false;
                  });
                }
              },
              children: [
                Image.asset(
                  'assets/first_image.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/second_image.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/third_image.png',
                  fit: BoxFit.cover,
                ),
              ]),
          isReady
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 100,
                      child: TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false),
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: buttonStyle(screenSize.width, secondColor),
                      ),
                    ),
                  ],
                )
              : Container()
        ]),
      ),
    );
  }
}
