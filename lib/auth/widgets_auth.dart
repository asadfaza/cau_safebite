//------------------------------------------------------------------------------------------
import 'package:cau_safebite/auth/login_page.dart';
import 'package:cau_safebite/auth/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Color firstColor = Colors.blueGrey;
Color secondColor = Color(0xffFF6A48);
Color bColor = Colors.grey.shade50;

class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Use a FadeTransition for the screen transition animation
    return FadeTransition(opacity: animation, child: child);
  }
}

ButtonStyle buttonStyle(double screenWidth, Color color) =>
    TextButton.styleFrom(
      //padding: const EdgeInsets.all(10),
      fixedSize: Size(screenWidth * 0.9, 45),
      backgroundColor: color,
      foregroundColor: (color == firstColor) ? Colors.white : Colors.black,
      textStyle: const TextStyle(fontSize: 17, fontFamily: 'Roboto Condensed'),
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );

InputDecoration fieldDesign(
        {required error, required icon, required text, required Size size}) =>
    InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 15),
        errorText: error,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: secondColor),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        suffixIcon: icon,
        labelText: text,
        labelStyle: TextStyle(
          fontSize: 15,
          color: (error != null) ? Colors.red : Colors.grey,
        ));

Widget buildButton(
    BuildContext context, String text, bool isLoginButton, double width) {
  return TextButton(
    onPressed: () {
      if (isLoginButton) {
        Navigator.push(
          context,
          FadePageRoute(builder: (context) => const Login()),
        );
      } else {
        Navigator.push(
          context,
          FadePageRoute(builder: (context) => const SignUp()),
        );
      }
    },
    style: TextButton.styleFrom(
      fixedSize: Size(width, 40),
      backgroundColor: isLoginButton ? firstColor : Colors.white,
      foregroundColor: isLoginButton ? Colors.white : firstColor,
      textStyle: const TextStyle(
          fontSize: 20,
          fontFamily: 'Roboto Condensed',
          fontWeight: FontWeight.w700),
      alignment: Alignment.center,
      side: isLoginButton
          ? BorderSide.none
          : BorderSide(color: firstColor, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    child: Text(text),
  );
}

Widget authTemplate({
  required Size size,
  required String title,
  required String subtitle,
  required bool isLogin,
  required context,
  required function,
}) =>
    SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7, bottom: isLogin ? 5 : 20),
          child: Text(
            subtitle,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(113, 113, 113, 1),
            ),
          ),
        ),
        function,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Don’t have an account?' : 'Already have an account?',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(113, 113, 113, 1),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    FadePageRoute(
                        builder: (context) => isLogin ? SignUp() : Login()));
              },
              child: Text(
                isLogin ? 'Sign up' : 'Login',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  color: secondColor,
                ),
              ),
            ),
          ],
        ),
      ]),
    );

class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  final _emailController = TextEditingController();
  var _errorText;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          .then((value) => Navigator.pushReplacement(context,
              FadePageRoute(builder: (context) => const confirmationScreen())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'channel-error') {
        setState(() {
          _errorText = 'Enter the valid email';
        });
      }
      if (e.code == 'user-not-found') {
        setState(() {
          _errorText = 'user not found';
        });
      }
      if (e.code == 'invalid-email') {
        setState(() {
          _errorText = 'invalid mail';
        });
      }
      print(e);
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bColor,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: bColor,
      body: Container(
        margin: EdgeInsets.only(
          left: screenSize.width * 0.05,
          right: screenSize.width * 0.05,
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 20),
              child: Row(
                children: [
                  Text(
                    'Input your email, so we can let you reset password.',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                onFieldSubmitted: (newValue) {
                  setState(() {
                    _isLoading = !_isLoading;
                  });
                  passwordReset();
                },
                controller: _emailController,
                cursorColor: firstColor,
                decoration: fieldDesign(
                    size: screenSize,
                    error: _errorText,
                    icon: null,
                    text: 'Email'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = !_isLoading;
                });
                passwordReset();
              },
              style: buttonStyle(screenSize.width, firstColor),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    )
                  : const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

class confirmationScreen extends StatelessWidget {
  const confirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: SizedBox(
        height: screenSize.height * 0.3,
        width: screenSize.width * 0.7,
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey),
            height: 80,
            width: 80,
            child: Icon(
              Icons.inbox,
              color: secondColor,
              size: 45,
            ),
          ),
          Text('Check your inbox',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 30),
            child: Text('We have sent you recover instructions to your email.',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              //padding: const EdgeInsets.all(10),
              fixedSize: Size(screenSize.width * 0.5, 45),
              backgroundColor: firstColor,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto Condensed',
                  fontWeight: FontWeight.w700),
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            child: const Text('Go to login page'),
          ),
        ]),
      ),
    ));
  }
}
