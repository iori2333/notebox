import 'package:flutter/material.dart';
import 'package:notebox/utils/theme.dart';

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 40,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(children: [
          Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
            ),
            child: const Icon(Icons.person),
          ),
          const SizedBox(width: 8),
          Text(
            'User',
            style: TextStyle(
              fontSize: 16,
              color: context.inversePrimary,
            ),
          ),
        ]),
      ),
    );
  }
}
