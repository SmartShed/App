import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/user.dart';
import '../../constants/colors.dart';
import '../pages.dart';

class UserTile extends StatefulWidget {
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
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.isSelected
            ? Colors.blue[100]
            : isHovered
                ? ColorConstants.hover
                : Colors.white,
        border: isHovered
            ? Border.all(
                color: ColorConstants.primary,
                width: 2,
              )
            : Border.all(
                color: Colors.transparent,
                width: 2,
              ),
      ),
      child: InkWell(
        onTap: () =>
            GoRouter.of(context).push(Pages.profile, extra: widget.user),
        onHover: (bool value) {
          setState(() {
            isHovered = value;
          });
        },
        child: ListTile(
          leading: CircleAvatar(
            child: Text(widget.user.name[0]),
          ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.email),
          trailing: Checkbox(
            value: widget.isSelected,
            onChanged: (bool? value) {
              widget.onSelect(value ?? false);
            },
          ),
        ),
      ),
    );
  }
}
