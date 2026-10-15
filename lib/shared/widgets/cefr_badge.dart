import 'package:flutter/material.dart';

import '../../app/theme.dart';

class CefrBadge extends StatelessWidget {
  final String? level;
  final double fontSize;

  const CefrBadge({super.key, this.level, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    if (level == null || level!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final color = AppTheme.getCefrColor(level);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        level!.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
