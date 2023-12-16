import 'package:flutter/material.dart';

import '../../widgets/dropdown.dart';
import '../../widgets/text_field.dart';

class RegisterStep2 extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController positionController;

  const RegisterStep2({
    Key? key,
    required this.nameController,
    required this.positionController,
  }) : super(key: key);

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  late FocusNode positionFocusNode;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    positionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    positionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          controller: widget.nameController,
          autoFocus: true,
          hintText: "Name",
          obscureText: false,
          suffixIcon: _nameIcon(),
          onEditingComplete: changeFocusToPosition,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 20),
        MyDropdown(
          focusNode: positionFocusNode,
          hintText: 'Position',
          controller: widget.positionController,
          items: const ['Worker', 'Supervisor', 'Authority'],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  IconButton _nameIcon() {
    return IconButton(
      onPressed: () {
        changeFocusToPosition();
      },
      icon: const Icon(Icons.done),
    );
  }

  void changeFocusToPosition() {
    setState(() {
      FocusScope.of(context).requestFocus(positionFocusNode);
    });
  }
}
