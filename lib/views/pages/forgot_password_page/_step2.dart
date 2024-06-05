import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_field.dart';

class ForgotPasswordStep2 extends StatefulWidget {
  final Key key;
  final TextEditingController otpController;
  final bool isPageInFocus;
  final void Function() resendOtp;

  const ForgotPasswordStep2({
    required this.key,
    required this.otpController,
    required this.isPageInFocus,
    required this.resendOtp,
  }) : super(key: key);

  @override
  State<ForgotPasswordStep2> createState() => _ForgotPasswordStep2State();
}

class _ForgotPasswordStep2State extends State<ForgotPasswordStep2> {
  int _counter = 120;
  bool _isTimerRunning = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isPageInFocus) startTimer();
  }

  @override
  void dispose() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _isTimerRunning = false;
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyTextField(
          controller: widget.otpController,
          autoFocus: true,
          hintText: "OTP",
          obscureText: false,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        Text("Resend OTP in $_counter seconds"),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isTimerRunning
              ? null
              : () {
                  widget.resendOtp();
                  startTimer();
                },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 5,
            shadowColor: ColorConstants.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            disabledBackgroundColor: Colors.grey[400],
          ),
          child: Text(
            "Resend OTP",
            style: TextStyle(
              color: _isTimerRunning ? Colors.grey[900] : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
