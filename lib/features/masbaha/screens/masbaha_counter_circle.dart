import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

/// Circle that displays the dhikr, the count, the target and the rounds.
/// Display only, no logic.
class MasbahaCounterCircle extends StatelessWidget {
  final String dhikr;
  final int count;
  final int target;
  final int rounds;

  const MasbahaCounterCircle({
    super.key,
    required this.dhikr,
    required this.count,
    required this.target,
    required this.rounds,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitleColor =
        isDark ? AppColors.subtitleDark : AppColors.subtitleLight;

    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring (visual only, progress will be wired up with the logic)
          SizedBox(
            width: 260,
            height: 260,
            child: CircularProgressIndicator(
              value: 0, // TODO(teammate): set to count / target
              strokeWidth: 10,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              color: AppColors.primary,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dhikr,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'الهدف: $count / $target',
                style: TextStyle(color: subtitleColor, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                'الدورات: $rounds',
                style: TextStyle(color: subtitleColor, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}