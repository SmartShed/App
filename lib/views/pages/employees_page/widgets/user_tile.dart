import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartshed/models/user.dart';
import 'package:smartshed/views/pages.dart';

class UserTile extends StatelessWidget {
  final SmartShedUser user;
  final bool isSelected;
  final ValueChanged<bool> onSelect;

  const UserTile({
    Key? key,
    required this.user,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected ? Colors.blue[100] : Colors.white,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name[0]),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (bool? value) {
            onSelect(value ?? false);
          },
        ),
        onTap: () {
          GoRouter.of(context).push(Pages.profile, extra: user);
        },
      ),
    );
  }
}
