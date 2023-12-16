import 'package:flutter/material.dart';

import '../../widgets/text_field.dart';

class ForgotPasswordStep3 extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const ForgotPasswordStep3({
    Key? key,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  State<ForgotPasswordStep3> createState() => _ForgotPasswordStep3State();
}

class _ForgotPasswordStep3State extends State<ForgotPasswordStep3> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          controller: widget.passwordController,
          autoFocus: false,
          focusNode: passwordFocusNode,
          hintText: "Password",
          obscureText: hidePassword,
          suffixIcon: _passwordIcon(),
          onEditingComplete: changeFocusToConfirmPassword,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 20),
        MyTextField(
          controller: widget.confirmPasswordController,
          autoFocus: false,
          focusNode: confirmPasswordFocusNode,
          hintText: "Confirm Password",
          obscureText: hideConfirmPassword,
          suffixIcon: _confirmPasswordIcon(),
          onEditingComplete: () {},
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 20),
      ],
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

  IconButton _confirmPasswordIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          hideConfirmPassword = !hideConfirmPassword;
        });
      },
      icon: Icon(hideConfirmPassword ? Icons.visibility : Icons.visibility_off),
    );
  }

  void changeFocusToPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  void changeFocusToConfirmPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
    });
  }
}
