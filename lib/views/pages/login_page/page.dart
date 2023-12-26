import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../controllers/auth/login.dart';
import '../../../controllers/toast/toast.dart';
import '../../pages.dart';
import '../../responsive/dimensions.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/text_field.dart';

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
      body: SingleChildScrollView(
        reverse: true,
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
                              const Text(
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
                                onEditingComplete: () {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocusNode);
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20),
                              MyTextField(
                                controller: passwordController,
                                autoFocus: false,
                                focusNode: passwordFocusNode,
                                hintText: "Password",
                                obscureText: hidePassword,
                                suffixIcon: _passwordIcon(),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      GoRouter.of(context)
                                          .go(Pages.forgotPassword);
                                    },
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
                                      onPressed: _loginWithGoogle,
                                      iconSize: 90,
                                      icon: Image.asset(
                                        ImageConstants.googleLogo,
                                        width: 90,
                                        height: 90,
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
                                      GoRouter.of(context).go(Pages.register);
                                    },
                                    child: const Text(
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
      onPressed: _login,
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

  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ToastController.warning("Please fill all the fields");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(title: "Logging in..."),
    );

    Map<String, dynamic>? response =
        await LoginController.login(email, password);

    if (!context.mounted) return;
    GoRouter.of(context).pop();

    if (response!['status'] == 'success') {
      ToastController.success(response['message']);
      if (!context.mounted) return;
      GoRouter.of(context).go(Pages.dashboard);
    } else {
      ToastController.error(response['message']);
    }
  }

  void _loginWithGoogle() async {
    Map<String, dynamic>? response = await LoginController.loginWithGoogle();

    if (response!['status'] == 'success') {
      ToastController.success(response['message']);
      if (!context.mounted) return;
      GoRouter.of(context).go(Pages.dashboard);
    } else {
      ToastController.error(response['message']);
    }
  }
}
