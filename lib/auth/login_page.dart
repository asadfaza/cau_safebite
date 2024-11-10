import 'package:cau_safebite/auth/auth.dart';
import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _password = true;
  bool _isLoading = false;
  bool _loadingGoogle = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _errorText;
  var _errorPassword;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bColor,
        appBar: AppBar(
          backgroundColor: bColor,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: Container(),
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                  left: screenSize.width * 0.05,
                  right: screenSize.width * 0.05,
                ),
                child: authTemplate(
                  size: screenSize,
                  title: 'Welcome Back',
                  subtitle:
                      'Input your email and password so you can login into your account',
                  isLogin: true,
                  context: context,
                  function: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                FadePageRoute(
                                    builder: (context) => forgetPassword())),
                            child: Text(
                              "Can’t sign in?",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                color: secondColor,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                            //ID text field
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            cursorColor: Colors.black,
                            decoration: fieldDesign(
                                error: _errorText,
                                icon: null,
                                text: 'Email',
                                size: screenSize)),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            obscureText: _password,
                            onFieldSubmitted: (value) {
                              setState(() {
                                _isLoading = !_isLoading;
                                _errorPassword = null;
                                _errorText = null;
                              });
                              logIn();
                            },
                            cursorColor: Colors.black,
                            decoration: fieldDesign(
                                size: screenSize,
                                error: _errorPassword,
                                icon: IconButton(
                                  icon: Icon(
                                    _password
                                        ? Icons.lock_outline
                                        : Icons.lock_open_outlined,
                                    size: 20,
                                    color: (_errorPassword != null)
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _password = !_password;
                                    });
                                  },
                                ),
                                text: 'Password'),
                          ),
                        ),
                      ]),
                )),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = !_isLoading;
                });
                logIn();
              },
              style: buttonStyle(screenSize.width, firstColor),
              child: _isLoading
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ))
                  : Text('Login'),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                color: Colors.grey,
                height: 1,
                width: screenSize.width * 0.89,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  setState(() {
                    _loadingGoogle = !_loadingGoogle;
                  });
                  final user = await signInWithGoogle();
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Welcome, ${user.displayName}!")));
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/custom', (route) => false);
                  }
                  setState(() {
                    _loadingGoogle = !_loadingGoogle;
                  });
                },
                style: buttonStyle(screenSize.width, Colors.grey.shade200),
                child: _loadingGoogle
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: firstColor,
                          strokeWidth: 3,
                        ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google_icon.png',
                            height: 35,
                          ),
                          Text('Sign in with Google'),
                        ],
                      ))
          ],
        ));
  }

  Future logIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text.trim())
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/custom', (route) => false));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        setState(() {
          _errorPassword = 'Wrong password';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _errorText = 'Enter the valid email';
        });
      } else if (e.code == 'too-many-requests') {
        setState(() {
          _errorPassword = 'Too many requests';
        });
      } else if (e.code == 'invalid-credential') {
        setState(() {
          _errorPassword = 'Wrong password';
        });
      } else if (e.code == 'user-not-found') {
        setState(() {
          _errorText = 'Email not found';
        });
      } else
        setState(() {
          _errorText = 'Error accure';
        });
      print(e);
    }
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
