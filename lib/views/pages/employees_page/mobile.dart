import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class EmployeesPageMobile extends StatefulWidget {
  const EmployeesPageMobile({super.key});

  @override
  State<EmployeesPageMobile> createState() => _EmployeesPageMobileState();
}

class _EmployeesPageMobileState extends State<EmployeesPageMobile> {
  @override
  void initState() {
    super.initState();
    const_file.changeState = setState;
    initConst();
  }

  @override
  Widget build(BuildContext context) {
    const_file.context = context;

    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          initConst();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Add employee form
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: buildAddEmployeeForm(),
                ),
                const SizedBox(height: 20),
                Container(
                  // add border
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: buildRemoveEmployeeForm(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
