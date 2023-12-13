import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../controllers/auth/forgot_password.dart';
import '../../../controllers/toast/toast.dart';
import '../../pages.dart';
import '../../responsive/dimensions.dart';
import '../../widgets/loading_dialog.dart';
import '_step1.dart';
import '_step2.dart';
import '_step3.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/forgot-password';

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
  late TextEditingController otpController;
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
    otpController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    positionController = TextEditingController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
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
                              const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: ColorConstants.primary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Enter your email address to reset your password",
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
                                      GoRouter.of(context).go(Pages.login);
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: ColorConstants.primary,
                                      ),
                                    ),
                                  )
                                ],
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
      title: const Text("Enter Email"),
      content: ForgotPasswordStep1(
        emailController: emailController,
      ),
      isActive: currentStep >= 0,
      state: currentStep <= 0 ? StepState.editing : StepState.complete,
    );
    Step step2 = Step(
      title: const Text("Enter OTP"),
      content: ForgotPasswordStep2(
        key: ValueKey(currentStep),
        otpController: otpController,
        isPageInFocus: currentStep == 1,
        resendOtp: _resendOtp,
      ),
      isActive: currentStep >= 1,
      state: currentStep <= 1 ? StepState.editing : StepState.complete,
    );
    Step step3 = Step(
      title: const Text(
        "Enter Password",
      ),
      content: ForgotPasswordStep3(
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
      ),
      isActive: currentStep >= 2,
      state: currentStep <= 2 ? StepState.editing : StepState.complete,
    );

    return [
      step1,
      step2,
      step3,
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
          if (currentStep == 0)
            ElevatedButton(
              onPressed: _sendOtp,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 5,
                shadowColor: ColorConstants.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Send OTP",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          if (currentStep == 1)
            ElevatedButton(
              onPressed: _validateOtp,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 5,
                shadowColor: ColorConstants.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Verify OTP",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          if (currentStep == 2)
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 5,
                shadowColor: ColorConstants.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Reset Password",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _sendOtp() async {
    String email = emailController.text;

    if (email.isEmpty) {
      ToastController.warning("Email cannot be empty");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(title: "Sending OTP"),
    );

    bool? response = await ForgotPasswordController.sendOTP(email);

    if (!context.mounted) return;
    GoRouter.of(context).pop();

    if (response == true) {
      setState(() => currentStep++);
    }
  }

  void _resendOtp() async {
    String email = emailController.text;

    if (email.isEmpty) {
      ToastController.warning("Email cannot be empty");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(title: "Resending OTP"),
    );

    await ForgotPasswordController.sendOTP(email);

    if (!context.mounted) return;
    GoRouter.of(context).pop();
  }

  void _validateOtp() async {
    String email = emailController.text;
    String otp = otpController.text;

    if (email.isEmpty) {
      ToastController.warning("Email cannot be empty");
      return;
    }

    if (otp.isEmpty) {
      ToastController.warning("OTP cannot be empty");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(title: "Validating OTP"),
    );

    bool? response = await ForgotPasswordController.validateOTP(email, otp);

    if (!context.mounted) return;
    GoRouter.of(context).pop();

    if (response == true) {
      setState(() => currentStep++);
    }
  }

  void _resetPassword() async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (email.isEmpty) {
      ToastController.warning("Email cannot be empty");
      return;
    }

    if (password.isEmpty) {
      ToastController.warning("Password cannot be empty");
      return;
    }

    if (confirmPassword.isEmpty) {
      ToastController.warning("Confirm Password cannot be empty");
      return;
    }

    if (password != confirmPassword) {
      ToastController.warning("Passwords do not match");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(title: "Resetting Password"),
    );

    bool? response =
        await ForgotPasswordController.resetPassword(email, password);

    if (!context.mounted) return;
    GoRouter.of(context).pop();

    if (response == true) {
      GoRouter.of(context).go(Pages.login);
    }
  }
}
