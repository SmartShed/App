import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../widgets/text_field.dart';
import '../../../controllers/auth/google_sign_in.dart';
import '../../../controllers/toast/toast.dart';
import '../../responsive/dimensions.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double maxContentWidth = 900;
  final double maxMainContentWidth = 600;

  final double tabletWidth = 1200;

  late double height, width;
  late double horizontalPadding;
  late double contentWidth;
  late double mainContentWidth;

  late double imageWidth;
  late double imagePadding;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late FocusNode passwordFocusNode;

  bool rememberUser = true;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    passwordFocusNode.dispose();

    super.dispose();
  }

  void _initilize() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    if (width < mobileWidth) {
      horizontalPadding = 0;
      contentWidth = width;
      mainContentWidth = width * 0.9;
    } else if (width < tabletWidth) {
      double percentage = (width - mobileWidth) / (tabletWidth - mobileWidth);
      contentWidth = mobileWidth + percentage * (maxContentWidth - mobileWidth);
      horizontalPadding = (width - contentWidth) / 2;
      mainContentWidth =
          mobileWidth * 0.9 + percentage * (maxMainContentWidth - mobileWidth);
    } else {
      contentWidth = maxContentWidth;
      horizontalPadding = (width - contentWidth) / 2;
      mainContentWidth = maxMainContentWidth;
    }

    imageWidth = min(contentWidth, height * 0.25) * 0.6;
    imagePadding = min(contentWidth, height * 0.25) * 0.1;
  }

  @override
  Widget build(BuildContext context) {
    _initilize();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height * 0.25,
                  color: ColorConstants.bg,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: imagePadding),
                      child: Image.asset(
                        ImageConstants.logo,
                        height: imageWidth,
                        width: imageWidth,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.75,
                  color: ColorConstants.bg,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10 + horizontalPadding,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                      ),
                      child: SingleChildScrollView(
                        controller: ScrollController(
                          initialScrollOffset: 0,
                          keepScrollOffset: true,
                        ),
                        padding: EdgeInsets.only(
                          left: (contentWidth - mainContentWidth) / 2,
                          right: (contentWidth - mainContentWidth) / 2,
                        ),
                        child: SizedBox(
                          width: contentWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                  color: ColorConstants.primary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Please login with your information",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              MyTextField(
                                controller: emailController,
                                autoFocus: true,
                                hintText: "Email",
                                obscureText: false,
                                suffixIcon: _emailIcon(),
                              ),
                              const SizedBox(height: 20),
                              MyTextField(
                                controller: passwordController,
                                autoFocus: false,
                                focusNode: passwordFocusNode,
                                hintText: "Password",
                                obscureText: hidePassword,
                                suffixIcon: _passwordIcon(),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: rememberUser,
                                        activeColor: ColorConstants.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            rememberUser = value!;
                                          });
                                        },
                                      ),
                                      const Text(
                                        "Remember me",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildLoginButton(),
                              const SizedBox(height: 40),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Or Login with",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    IconButton(
                                      onPressed: signInWithGoogle,
                                      iconSize: 70,
                                      icon: Image.asset(
                                        ImageConstants.googleLogo,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // TODO: Navigate to register page
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: ColorConstants.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconButton _emailIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          FocusScope.of(context).requestFocus(passwordFocusNode);
        });
      },
      icon: const Icon(Icons.done),
    );
  }

  IconButton _passwordIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          hidePassword = !hidePassword;
        });
      },
      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Login API call
        ToastController.show("Login Successful");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: ColorConstants.primary,
        backgroundColor: ColorConstants.primary,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "LOGIN",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Future signInWithGoogle() async => await GoogleSignInAPI.signIn();
}
