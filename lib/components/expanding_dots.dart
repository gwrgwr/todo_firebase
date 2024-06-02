import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ExpandingDots extends StatelessWidget {
  final int totalPages;
  final double offset;
  final double size;
  final double expandedSize;
  final Color color;
  final double spacing;

  const ExpandingDots({
    super.key,
    required this.totalPages,
    required this.offset,
    this.size = 15,
    this.expandedSize = 50,
    this.color = Colors.white,
    this.spacing = 5,
  });

  @override
  Widget build(BuildContext context) {
    final children = List.generate(totalPages, (index) {
      return Container(
        margin: index == (totalPages - 1) ? null : EdgeInsets.only(right: spacing),
        width: _sizeCalc(index, offset),
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
        ),
      );
    });

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  double _sizeCalc(int page, double offset) {
    final interpolation = (page - offset).abs();

    return max(lerpDouble(expandedSize, size, interpolation) ?? size, size);
  }
}