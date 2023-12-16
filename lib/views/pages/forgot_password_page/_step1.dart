import 'package:flutter/material.dart';

import '../../widgets/text_field.dart';

class ForgotPasswordStep1 extends StatefulWidget {
  final TextEditingController emailController;

  const ForgotPasswordStep1({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  State<ForgotPasswordStep1> createState() => _ForgotPasswordStep1State();
}

class _ForgotPasswordStep1State extends State<ForgotPasswordStep1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          controller: widget.emailController,
          autoFocus: true,
          hintText: "Email",
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
