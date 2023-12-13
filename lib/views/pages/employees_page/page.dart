import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartshed/controllers/auth/login.dart';
import 'package:smartshed/controllers/smartshed/employees.dart';
import 'package:smartshed/models/user.dart';
import 'package:smartshed/views/pages/employees_page/widgets/user_tile.dart';
import 'package:smartshed/views/widgets/drawer.dart';
import 'package:smartshed/views/widgets/loading_dialog.dart';
import 'package:smartshed/views/widgets/text_field.dart';

class EmployeesPage extends StatefulWidget {
  static const String routeName = '/employees';

  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  bool isShowingAddEmployee = false;
  bool isShowingRemoveEmployee = true;

  bool isLoadingUsers = true;

  List<String> authorityEmails = [''];
  List<String> supervisorEmails = [''];
  List<String> workerEmails = [''];

  late List<SmartShedUser> authorityUsers;
  late List<SmartShedUser> supervisorUsers;
  late List<SmartShedUser> workerUsers;

  List<String> selectedUserIds = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      isLoadingUsers = true;
    });

    Map<String, List<SmartShedUser>> users = await EmployeesController.getUsers(
      forSupervisor: LoginController.isSupervisor,
    );

    authorityUsers = users['authority']!;
    supervisorUsers = users['supervisor']!;
    workerUsers = users['worker']!;

    authorityUsers.sort((a, b) => a.name.compareTo(b.name));
    supervisorUsers.sort((a, b) => a.name.compareTo(b.name));
    workerUsers.sort((a, b) => a.name.compareTo(b.name));

    setState(() {
      isLoadingUsers = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Employees",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Show button to add employee
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
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isShowingAddEmployee = !isShowingAddEmployee;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isShowingAddEmployee
                                ? "Hide Add Employee Form"
                                : "Show Add Employee Form",
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
                    ),
                    if (isShowingAddEmployee) ...[
                      const SizedBox(height: 20),
                      // Show button to load employee from google sheet
                      TextButton(
                        onPressed: () {
                          loadEmployeesFromGoogleSheet(context);
                        },
                        // add border
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
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Load Employees From Google Sheet",
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
                      ),
                      const SizedBox(height: 20),
                      if (LoginController.isAuthority) ...[
                        buildAddEmployee(authorityEmails, "Authority Email"),
                        buildAddEmployee(supervisorEmails, "Supervisor Email"),
                      ],
                      buildAddEmployee(workerEmails, "Worker Email"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          submit(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            "Add Employees",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Show button to remove employee
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
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isShowingRemoveEmployee = !isShowingRemoveEmployee;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isShowingRemoveEmployee
                                ? "Hide Manage Employee"
                                : "Show Manage Employee",
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
                    ),
                    if (isShowingRemoveEmployee) ...[
                      isLoadingUsers
                          ? const CircularProgressIndicator()
                          : Column(
                              children: [
                                if (LoginController.isAuthority) ...[
                                  const SizedBox(height: 20),
                                  Text(
                                    "Authorities",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  buildUserList(authorityUsers),
                                ],
                                const SizedBox(height: 20),
                                if (LoginController.isAuthority ||
                                    LoginController.isSupervisor) ...[
                                  Text(
                                    "Supervisors",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  buildUserList(supervisorUsers),
                                ],
                                const SizedBox(height: 20),
                                Text(
                                  "Workers",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[900],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                buildUserList(workerUsers),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: selectedUserIds.isEmpty
                                      ? null
                                      : () {
                                          deleteSelectedUsers(context);
                                        },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      "Delete Users",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
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
                          "Add $title",
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
              setState(() => list.removeAt(index));
            },
          ),
        );
      },
    );
  }

  void _addTextField(List<String> list) {
    setState(() {
      list.add('');
    });
  }

  void submit(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(
        title: "Adding Employees...",
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

    await EmployeesController.addEmployees(emails);

    if (!context.mounted) return;
    GoRouter.of(context).pop();
  }

  void loadEmployeesFromGoogleSheet(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(
        title: "Loading Employees...",
      ),
    );

    Map<String, List<String>> employeesFromGoogleSheet =
        await EmployeesController.getEmployeesFromGoogleSheet();

    Map<String, List<String>> employees =
        await EmployeesController.getEmployees();

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

    setState(() {});

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
            setState(() {
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

  void deleteSelectedUsers(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(
        title: "Deleting Employees...",
      ),
    );

    // await EmployeesController.deleteUsers(selectedUserIds);
    print(selectedUserIds);

    if (!context.mounted) return;
    GoRouter.of(context).pop();
  }
}
