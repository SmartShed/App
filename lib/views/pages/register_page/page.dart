import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../controllers/auth/register.dart';
import '../../../controllers/toast/toast.dart';
import '../../pages.dart';
import '../../responsive/dimensions.dart';
import './register_step1.dart';
import './register_step2.dart';
import '../../widgets/loading_dialog.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  late TextEditingController positionController;

  late ScrollController scrollController;

  int currentStep = 0;
  bool isGoogleSignIn = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    positionController = TextEditingController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    positionController.dispose();
    scrollController.dispose();
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
                        controller: scrollController,
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
                                "Welcome",
                                style: TextStyle(
                                  color: ColorConstants.primary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Please enter your details to continue",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Stepper(
                                currentStep: currentStep,
                                steps: _getSteps(),
                                controlsBuilder: controlBuilder,
                                controller: scrollController,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.pushReplacementNamed(
                                      // context, Pages.login);
                                      GoRouter.of(context).go(Pages.login);
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: ColorConstants.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 50),
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

  List<Step> _getSteps() {
    Step step1 = Step(
      title: const Text("Email and Password"),
      content: RegisterStep1(
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        registerWithGoogle: _registerWithGoogle,
        isRegisterWithGoogle: isGoogleSignIn,
        enableRegisterWithGoogle: enableRegisterWithGoogle,
        disableRegisterWithGoogle: disableRegisterWithGoogle,
        paddingForDialog: horizontalPadding + 40,
      ),
      isActive: currentStep >= 0,
      state: currentStep <= 0 ? StepState.editing : StepState.complete,
    );

    Step step2 = Step(
      title: const Text("Name and Position"),
      content: RegisterStep2(
        nameController: nameController,
        positionController: positionController,
      ),
      isActive: currentStep >= 1,
      state: currentStep <= 1 ? StepState.editing : StepState.complete,
    );

    return [
      step1,
      step2,
    ];
  }

  Widget controlBuilder(BuildContext context, ControlsDetails details) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (currentStep > 0)
            TextButton(
              onPressed: () {
                if (currentStep > 0) {
                  setState(() {
                    currentStep--;
                  });
                }
              },
              child: const Text("Back"),
            ),
          if (currentStep < _getSteps().length - 1)
            ElevatedButton(
              onPressed: () {
                if (currentStep < _getSteps().length - 1) {
                  setState(() {
                    currentStep++;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 5,
                shadowColor: ColorConstants.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text("Next"),
            ),
          if (currentStep == _getSteps().length - 1)
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 5,
                shadowColor: ColorConstants.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text("REGISTER"),
            ),
        ],
      ),
    );
  }

  Future<bool> _registerWithGoogle() async {
    Map<String, dynamic>? user =
        await RegisterController.showGoogleSignInDialog();

    if (user == null) {
      ToastController.error("Google sign in failed");
      return false;
    }

    nameController.text = user["name"];
    emailController.text = user["email"];

    ToastController.success("Google sign in successful");
    isGoogleSignIn = true;

    setState(() {
      currentStep++;
    });

    return true;
  }

  void _register() async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String name = nameController.text;
    String position = positionController.text;

    if (email.isEmpty) {
      ToastController.warning("Email cannot be empty");

      setState(() {
        currentStep = 0;
      });

      return;
    }

    if (!isGoogleSignIn && password.isEmpty) {
      ToastController.warning("Password cannot be empty");

      setState(() {
        currentStep = 0;
      });

      return;
    }

    if (!isGoogleSignIn && confirmPassword.isEmpty) {
      ToastController.warning("Confirm password cannot be empty");

      setState(() {
        currentStep = 0;
      });

      return;
    }

    if (name.isEmpty) {
      ToastController.warning("Name cannot be empty");
      return;
    }

    if (position.isEmpty) {
      ToastController.warning("Position cannot be empty");
      return;
    }

    position = position.toLowerCase();

    if (!isGoogleSignIn && password != confirmPassword) {
      ToastController.warning("Passwords do not match");

      setState(() {
        currentStep = 0;
      });

      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(title: "Registering..."),
    );

    Map<String, dynamic>? response = {};

    if (isGoogleSignIn) {
      response = await RegisterController.registerWithGoogle(
        email,
        name,
        position,
      );
    } else {
      response = await RegisterController.register(
        email,
        password,
        name,
        position,
      );
    }

    if (!context.mounted) return;
    // Navigator.pop(context);
    GoRouter.of(context).pop();

    if (response!['status'] == 'success') {
      ToastController.success(response['message']);
      if (!context.mounted) return;
      // Navigator.pushNamedAndRemoveUntil(
      // context, Pages.dashboard, (Route<dynamic> route) => false);
      GoRouter.of(context).go(Pages.dashboard);
    } else {
      ToastController.error(response['message']);
    }
  }

  void enableRegisterWithGoogle() {
    if (isGoogleSignIn == false) {
      setState(() {
        isGoogleSignIn = true;
      });
    }
  }

  void disableRegisterWithGoogle() {
    if (isGoogleSignIn == true) {
      setState(() {
        isGoogleSignIn = false;
      });
    }
  }
}
