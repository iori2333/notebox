import 'package:flutter/material.dart';
import 'package:notebox/utils/theme.dart';

class RouteTile extends StatelessWidget {
  const RouteTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Widget title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var decoration = isActive
        ? BoxDecoration(
            color: context.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          )
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: decoration,
          height: 42,
          child: Row(
            children: [
              const SizedBox(width: 8),
              icon,
              const SizedBox(width: 8),
              Expanded(child: title),
            ],
          ),
        ),
      ),
    );
  }
}
