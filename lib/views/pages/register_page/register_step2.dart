import 'package:flutter/material.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../models/section.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/text_field.dart';

class RegisterStep2 extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController positionController;
  final TextEditingController sectionController;

  const RegisterStep2({
    Key? key,
    required this.nameController,
    required this.positionController,
    required this.sectionController,
  }) : super(key: key);

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  late FocusNode positionFocusNode;
  String? selectedValue;
  bool isSectionLoading = true;

  List<String> positionArray = ['Authority', 'Supervisor', 'Worker'];
  late List<String> sectionArray;

  @override
  void initState() {
    super.initState();
    initSectionArray();
    positionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    positionFocusNode.dispose();
    super.dispose();
  }

  Future<void> initSectionArray() async {
    final List<SmartShedSection> sections =
        await DashboardForAllController.getSections();

    sectionArray = sections.map((e) => e.title).toList();
    setState(() {
      isSectionLoading = false;
    });
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
          items: positionArray,
          onChanged: () => setState(() {}),
        ),
        const SizedBox(height: 20),
        if (widget.positionController.text != '' &&
            widget.positionController.text != 'Authority')
          isSectionLoading
              ? const Center(child: CircularProgressIndicator())
              : MyDropdown(
                  hintText: 'Section',
                  controller: widget.sectionController,
                  items: sectionArray,
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
