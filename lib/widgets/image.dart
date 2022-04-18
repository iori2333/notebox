import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    this.src,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String? src;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final image = src == null
        ? null
        : DecorationImage(
            image: NetworkImage(src!),
            fit: BoxFit.cover,
          );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: image,
        color: src == null ? const Color(0x0f3f3f3f) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );
  }
}
