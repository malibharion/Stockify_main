import 'dart:ui';

import 'package:flutter/material.dart';

class StepperArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Start from top left corner
    path.moveTo(0, 0);

    // Top side to right
    path.lineTo(size.width * 0.85, 0);

    // Top right arrow point
    path.lineTo(size.width, size.height / 2);

    // Bottom right arrow point to left
    path.lineTo(size.width * 0.85, size.height);

    // Bottom side to left inward (stepper)
    path.lineTo(size.width * 0.15, size.height);

    // Bottom inward stepper point
    path.lineTo(size.width * 0.1, size.height / 2);

    // Close the path to the starting point
    path.lineTo(size.width * 0.15, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
