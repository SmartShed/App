import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class EmployeesPageDesktop extends StatefulWidget {
  const EmployeesPageDesktop({super.key});

  @override
  State<EmployeesPageDesktop> createState() => _EmployeesPageDesktopState();
}

class _EmployeesPageDesktopState extends State<EmployeesPageDesktop> {
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
      body: RefreshIndicator(
        onRefresh: () async {
          initConst();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyDrawer(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 10,
                        ),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 10,
                        ),
                        child: buildRemoveEmployeeForm(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
