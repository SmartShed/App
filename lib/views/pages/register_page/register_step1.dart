import 'package:flutter/material.dart';

import '../../../constants/images.dart';
import '../../widgets/disable_google_sign_in.dart';
import '../../widgets/text_field.dart';

class RegisterStep1 extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isRegisterWithGoogle;

  // Callbacks
  final Future<bool> Function() registerWithGoogle;
  final void Function() enableRegisterWithGoogle;
  final void Function() disableRegisterWithGoogle;

  final double paddingForDialog;

  const RegisterStep1({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.registerWithGoogle,
    required this.isRegisterWithGoogle,
    required this.enableRegisterWithGoogle,
    required this.disableRegisterWithGoogle,
    required this.paddingForDialog,
  }) : super(key: key);

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
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
          controller: widget.emailController,
          autoFocus: true,
          hintText: "Email",
          obscureText: false,
          suffixIcon: _emailIcon(),
          onEditingComplete: changeFocusToPassword,
          readOnly: widget.isRegisterWithGoogle,
          onTap: disableRegisterWithGoogle,
        ),
        const SizedBox(height: 20),
        MyTextField(
          controller: widget.passwordController,
          autoFocus: false,
          focusNode: passwordFocusNode,
          hintText: "Password",
          obscureText: hidePassword,
          suffixIcon: _passwordIcon(),
          onEditingComplete: changeFocusToConfirmPassword,
          readOnly: widget.isRegisterWithGoogle,
          onTap: disableRegisterWithGoogle,
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
          readOnly: widget.isRegisterWithGoogle,
          onTap: disableRegisterWithGoogle,
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 40),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Or register with",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: _registerWithGoogle,
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
      ],
    );
  }

  void _registerWithGoogle() async {
    bool result = await widget.registerWithGoogle();

    if (result) {
      widget.enableRegisterWithGoogle();
    }
  }

  IconButton _emailIcon() {
    return IconButton(
      onPressed: () {
        changeFocusToPassword();
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

  void disableRegisterWithGoogle() {
    if (!widget.isRegisterWithGoogle) {
      return;
    }

    showDialog(
      context: context,
      builder: (_) => DisableGoogleSignInDialog(
        onDisable: () => widget.disableRegisterWithGoogle(),
        paddingForBox: widget.paddingForDialog,
      ),
    );
  }
}
