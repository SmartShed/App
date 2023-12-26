import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/auth/login.dart';
import '../../../controllers/smartshed/employees.dart';
import '../../../controllers/toast/toast.dart';
import '../../../models/user.dart';
import '../../localization/employees.dart';
import '../../localization/toast.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/text_field.dart';
import '../../widgets/user_tile.dart';

bool isShowingAddEmployee = false;
bool isShowingRemoveEmployee = true;

bool isLoadingUsers = true;

List<String> authorityEmails = [''];
List<String> supervisorEmails = [''];
List<String> workerEmails = [''];

late List<SmartShedUser> authorityUsers;
late List<SmartShedUser> supervisorUsers;
late List<SmartShedUser> workerUsers;

bool isShowingAuthority = true;
bool isShowingSupervisor = true;
bool isShowingWorker = true;

List<String> selectedUserIds = [];

late BuildContext context;
late void Function(void Function()) changeState;

void initConst() async {
  changeState(() {
    isLoadingUsers = true;
  });

  authorityEmails = [''];
  supervisorEmails = [''];
  workerEmails = [''];

  isShowingAddEmployee = false;
  isShowingRemoveEmployee = true;

  Map<String, List<SmartShedUser>>? users = await EmployeesController.getUsers(
    forSupervisor: LoginController.isSupervisor,
  );

  if (!context.mounted) return;
  if (users == null) {
    ToastController.error(
        Toast_LocaleData.error_while_fetching_users.getString(context));
    return;
  }

  authorityUsers = users['authority']!;
  supervisorUsers = users['supervisor']!;
  workerUsers = users['worker']!;

  authorityUsers.sort((a, b) => a.name.compareTo(b.name));
  supervisorUsers.sort((a, b) => a.name.compareTo(b.name));
  workerUsers.sort((a, b) => a.name.compareTo(b.name));

  changeState(() {
    isLoadingUsers = false;
  });
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Employees_LocaleData.title.getString(context),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

// Add Employee Form Widgets

Widget buildEmployeeFormButton() {
  return TextButton(
    onPressed: () {
      changeState(() {
        isShowingAddEmployee = !isShowingAddEmployee;
      });
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isShowingAddEmployee
              ? Employees_LocaleData.hide_add_employee_form.getString(context)
              : Employees_LocaleData.show_add_employee_form.getString(context),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900],
          ),
        ),
        const SizedBox(width: 10),
        Icon(
          isShowingAddEmployee
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          color: Colors.grey[900],
        ),
      ],
    ),
  );
}

Widget buildLoadEmployeesFromGoogleSheetButton() {
  return TextButton(
    onPressed: loadEmployeesFromGoogleSheet,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.grey[100],
      ),
      side: MaterialStateProperty.all(
        const BorderSide(
          color: Colors.grey,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 15,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Employees_LocaleData.load_employees_from_google_sheet
              .getString(context),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900],
          ),
        ),
        const SizedBox(width: 10),
        Icon(
          Icons.cloud_download,
          color: Colors.grey[900],
        ),
      ],
    ),
  );
}

Widget buildAddEmployeeButton() {
  return ElevatedButton(
    onPressed: () {
      submit();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Text(
        Employees_LocaleData.add_employees.getString(context),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget buildAddEmployeeForm() {
  return Column(
    children: [
      buildEmployeeFormButton(),
      if (isShowingAddEmployee) ...[
        const SizedBox(height: 20),
        buildLoadEmployeesFromGoogleSheetButton(),
        const SizedBox(height: 20),
        if (LoginController.isAuthority) ...[
          buildAddEmployee(
            authorityEmails,
            Employees_LocaleData.authority_email.getString(context),
          ),
          buildAddEmployee(
            supervisorEmails,
            Employees_LocaleData.supervisor_email.getString(context),
          ),
        ],
        buildAddEmployee(
          workerEmails,
          Employees_LocaleData.worker_email.getString(context),
        ),
        const SizedBox(height: 30),
        buildAddEmployeeButton(),
        const SizedBox(height: 30),
      ],
    ],
  );
}

// Remove Employee Form Widgets

Widget buildRemoveEmployeeFormButton() {
  return TextButton(
    onPressed: () {
      changeState(() {
        isShowingRemoveEmployee = !isShowingRemoveEmployee;
      });
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isShowingRemoveEmployee
              ? Employees_LocaleData.hide_manage_employee.getString(context)
              : Employees_LocaleData.show_manage_employee.getString(context),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900],
          ),
        ),
        const SizedBox(width: 10),
        Icon(
          isShowingRemoveEmployee
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          color: Colors.grey[900],
        ),
      ],
    ),
  );
}

Widget buildRemoveEmployeeButton() {
  return ElevatedButton(
    onPressed: selectedUserIds.isEmpty ? null : deleteSelectedUsers,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Text(
        Employees_LocaleData.delete_employees.getString(context),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget buildRemoveEmployeeUserList() {
  return Column(
    children: [
      if (LoginController.isAuthority) ...[
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                changeState(() {
                  isShowingAuthority = !isShowingAuthority;
                });
              },
              child: Row(
                children: [
                  Text(
                    isShowingAuthority
                        ? Employees_LocaleData.hide_authorities
                            .getString(context)
                        : Employees_LocaleData.show_authorities
                            .getString(context),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    isShowingAuthority
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[900],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (isShowingAuthority) ...[
          buildUserList(authorityUsers),
        ],
      ],
      const SizedBox(height: 20),
      if (LoginController.isAuthority || LoginController.isSupervisor) ...[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                changeState(() {
                  isShowingSupervisor = !isShowingSupervisor;
                });
              },
              child: Row(
                children: [
                  Text(
                    isShowingSupervisor
                        ? Employees_LocaleData.hide_supervisors
                            .getString(context)
                        : Employees_LocaleData.show_supervisors
                            .getString(context),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    isShowingSupervisor
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[900],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (isShowingSupervisor) ...[
          buildUserList(supervisorUsers),
        ],
      ],
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              changeState(() {
                isShowingWorker = !isShowingWorker;
              });
            },
            child: Row(
              children: [
                Text(
                  isShowingWorker
                      ? Employees_LocaleData.hide_workers.getString(context)
                      : Employees_LocaleData.show_workers.getString(context),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[900],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  isShowingWorker
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey[900],
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      if (isShowingWorker) ...[
        buildUserList(workerUsers),
      ],
      const SizedBox(height: 30),
      buildRemoveEmployeeButton(),
      const SizedBox(height: 30),
    ],
  );
}

Widget buildRemoveEmployeeForm() {
  return Column(
    children: [
      buildRemoveEmployeeFormButton(),
      if (isShowingRemoveEmployee) ...[
        isLoadingUsers
            ? const CircularProgressIndicator()
            : buildRemoveEmployeeUserList(),
        const SizedBox(height: 20),
      ],
    ],
  );
}

// Helper Functions

void loadEmployeesFromGoogleSheet() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(
      title: Employees_LocaleData.loading_employees.getString(context),
    ),
  );

  Map<String, List<String>>? employeesFromGoogleSheet =
      await EmployeesController.getEmployeesFromGoogleSheet();

  if (!context.mounted) return;
  if (employeesFromGoogleSheet == null) {
    ToastController.error(Toast_LocaleData
        .error_while_fetching_employees_from_google_sheet
        .getString(context));
    return;
  }

  Map<String, List<String>>? employees =
      await EmployeesController.getEmployees();

  if (!context.mounted) return;
  if (employees == null) {
    ToastController.error(
        Toast_LocaleData.error_while_fetching_employees.getString(context));
    return;
  }

  authorityEmails = [
    ...authorityEmails,
    ...employeesFromGoogleSheet['authority']!
        .where((email) => !employees['authority']!.contains(email))
        .toList(),
  ];

  authorityEmails = authorityEmails.toSet().toList();
  authorityEmails.removeWhere((email) => email == '');

  if (authorityEmails.isEmpty) {
    authorityEmails.add('');
  }

  supervisorEmails = [
    ...supervisorEmails,
    ...employeesFromGoogleSheet['supervisor']!
        .where((email) => !employees['supervisor']!.contains(email))
        .toList(),
  ];

  supervisorEmails = supervisorEmails.toSet().toList();
  supervisorEmails.removeWhere((email) => email == '');

  if (supervisorEmails.isEmpty) {
    supervisorEmails.add('');
  }

  workerEmails = [
    ...workerEmails,
    ...employeesFromGoogleSheet['worker']!
        .where((email) => !employees['worker']!.contains(email))
        .toList(),
  ];

  workerEmails = workerEmails.toSet().toList();
  workerEmails.removeWhere((email) => email == '');

  if (workerEmails.isEmpty) {
    workerEmails.add('');
  }

  changeState(() {});

  if (!context.mounted) return;
  GoRouter.of(context).pop();
}

Widget buildAddEmployee(List<String> list, String title) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: list.length + 1,
    itemBuilder: (context, index) {
      if (index == list.length) {
        return ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _addTextField(list);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(height: 5),
                      Text(
                        context.formatString(
                            Employees_LocaleData.add_employee_title, [title]),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return ListTile(
        title: MyTextField(
          onChanged: (text) {
            list[index] = text;
          },
          hintText: title,
          isTextCentered: true,
          initialValue: list[index],
          keyboardType: TextInputType.emailAddress,
        ),
        leading: IconButton(
          onPressed: () {},
          iconSize: 20,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          color: Colors.grey[700],
          icon: const Icon(Icons.email),
        ),
        trailing: IconButton(
          iconSize: 20,
          color: Colors.grey[700],
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            if (list.length == 1) return;
            changeState(() => list.removeAt(index));
          },
        ),
      );
    },
  );
}

void _addTextField(List<String> list) {
  changeState(() {
    list.add('');
  });
}

void submit() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(
      title: Employees_LocaleData.adding_employees.getString(context),
    ),
  );

  List<List<String>> emails = [];

  if (LoginController.isAuthority) {
    emails.add(authorityEmails);
    emails.add(supervisorEmails);
  } else {
    emails.add(['']);
    emails.add(['']);
  }
  emails.add(workerEmails);

  bool isAdded = await EmployeesController.addEmployees(emails);

  if (!context.mounted) return;
  if (isAdded) {
    ToastController.success(
        Toast_LocaleData.employee_added_successfully.getString(context));
  } else {
    ToastController.error(
        Toast_LocaleData.error_adding_employee.getString(context));
  }

  authorityEmails = [''];
  supervisorEmails = [''];
  workerEmails = [''];

  changeState(() {
    isShowingAddEmployee = false;
  });

  if (!context.mounted) return;
  GoRouter.of(context).pop();
}

Widget buildUserList(List<SmartShedUser> users) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: users.length,
    itemBuilder: (context, index) {
      return UserTile(
        user: users[index],
        isSelected: selectedUserIds.contains(users[index].id),
        onSelect: (bool value) {
          changeState(() {
            if (value) {
              selectedUserIds.add(users[index].id);
            } else {
              selectedUserIds.remove(users[index].id);
            }
          });
        },
      );
    },
  );
}

void deleteSelectedUsers() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(
      title: Employees_LocaleData.deleting_employees.getString(context),
    ),
  );

  bool isDeleted = await EmployeesController.deleteUsers(selectedUserIds);

  if (!context.mounted) return;
  if (isDeleted) {
    ToastController.success(
        Toast_LocaleData.users_deleted_successfully.getString(context));
  } else {
    ToastController.error(
        Toast_LocaleData.error_deleting_users.getString(context));
  }

  // Reload users
  Map<String, List<SmartShedUser>>? users = await EmployeesController.getUsers(
    forSupervisor: LoginController.isSupervisor,
  );

  if (!context.mounted) return;
  if (users == null) {
    ToastController.error(
        Toast_LocaleData.error_while_fetching_users.getString(context));
    return;
  }

  authorityUsers = users['authority']!;
  supervisorUsers = users['supervisor']!;
  workerUsers = users['worker']!;
  authorityUsers.sort((a, b) => a.name.compareTo(b.name));
  supervisorUsers.sort((a, b) => a.name.compareTo(b.name));
  workerUsers.sort((a, b) => a.name.compareTo(b.name));

  selectedUserIds = [];

  changeState(() {});

  if (!context.mounted) return;
  GoRouter.of(context).pop();
}
