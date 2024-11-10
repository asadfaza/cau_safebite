import 'package:cau_safebite/auth/auth.dart';
import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _password = true;
  bool _reEnteredPassword = true;
  bool _isLoading = false;
  bool _loadingGoogle = false;
  Map<String, dynamic> links = {};
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reEntredPasswordController = TextEditingController();
  var _errorText;
  var _errorID;
  var _errorPassword;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _reEntredPasswordController.dispose();
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
            Center(
              child: Container(
                  margin: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05,
                  ),
                  child: authTemplate(
                    size: screenSize,
                    title: 'Sign up',
                    subtitle:
                        'Input your email and password so you can use the application',
                    isLogin: false,
                    context: context,
                    function: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _emailController,
                                cursorColor: Colors.black,
                                decoration: fieldDesign(
                                    size: screenSize,
                                    error: _errorID,
                                    icon: null,
                                    text: 'Email')),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _passwordController,
                                  obscureText: _password,
                                  cursorColor: Colors.black,
                                  decoration: fieldDesign(
                                      size: screenSize,
                                      error: _errorText,
                                      icon: IconButton(
                                        icon: Icon(
                                          _password
                                              ? Icons.lock_outline
                                              : Icons.lock_open_outlined,
                                          size: 20,
                                          color: (_errorText != null)
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _password = !_password;
                                          });
                                        },
                                      ),
                                      text: 'Password')),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                                onFieldSubmitted: (newValue) => checkSignUp(),
                                textInputAction: TextInputAction.done,
                                controller: _reEntredPasswordController,
                                obscureText: _reEnteredPassword,
                                cursorColor: Colors.black,
                                decoration: fieldDesign(
                                    size: screenSize,
                                    error: _errorPassword,
                                    icon: IconButton(
                                      icon: Icon(
                                        _reEnteredPassword
                                            ? Icons.lock_outline
                                            : Icons.lock_open_outlined,
                                        size: 20,
                                        color: (_errorPassword != null)
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _reEnteredPassword =
                                              !_reEnteredPassword;
                                        });
                                      },
                                    ),
                                    text: 'Re-enter Password')),
                          ),
                        ]),
                  )),
            ),
            TextButton(
              onPressed: () => checkSignUp(),
              style: buttonStyle(screenSize.width, firstColor),
              child: _isLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ))
                  : const Text('Sign up'),
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

  Future signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text.trim())
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/custom', (route) => false));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          _errorID = 'Email already exist';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _errorID = 'Enter the Email correctly';
        });
      } else if (e.code == 'invalid-credential') {
        setState(() {
          _errorID = 'Email in use with another credential';
        });
      }
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  void checkSignUp() {
    setState(() {
      if (_passwordController.text != _reEntredPasswordController.text) {
        _errorPassword = 'Password not the same';
      } else
        _errorPassword = null;
      if (_passwordController.text.length < 8) {
        _errorText = 'Enter at least 8 char';
      } else {
        _errorText = null;
      }
    });
    setState(() {
      _isLoading = !_isLoading;
      _errorID = null;
    });
    if (_passwordController.text == _reEntredPasswordController.text) {
      signUp();
    }
  }
}
