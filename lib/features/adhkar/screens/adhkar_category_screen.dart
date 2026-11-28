
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr_model.dart';

class AdhkarCategoryScreen extends StatefulWidget {
  final String categoryTitle;

  const AdhkarCategoryScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  State<AdhkarCategoryScreen> createState() =>
      _AdhkarCategoryScreenState();
}

class _AdhkarCategoryScreenState
    extends State<AdhkarCategoryScreen> {
  late final List<Dhikr> adhkar;
  late final List<int> counters;

  @override
  void initState() {
    super.initState();

    adhkar = AdhkarData.categories[widget.categoryTitle] ?? [];

    counters = List<int>.filled(adhkar.length, 0);
  }

  int get completedCount {
    int count = 0;

    for (int i = 0; i < adhkar.length; i++) {
      if (counters[i] >= adhkar[i].repeat) {
        count++;
      }
    }

    return count;
  }

  void incrementCounter(int index) {
    setState(() {
      if (counters[index] < adhkar[index].repeat) {
        counters[index]++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;

    final cardColor = isDark
        ? AppColors.cardDark
        : AppColors.surfaceLight;

    final textColor = isDark
        ? AppColors.textDark
        : AppColors.textLight;

    final subtitleColor = isDark
        ? AppColors.subtitleDark
        : AppColors.subtitleLight;

    final borderColor = isDark
        ? AppColors.borderDark
        : const Color(0xFFE6E3DA);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: Text(
          widget.categoryTitle,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
      ),

      body: adhkar.isEmpty
          ? Center(
              child: Text(
                'لا توجد أذكار في هذا القسم',
                style: TextStyle(color: textColor),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  widget.categoryTitle,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'اجعل لسانك رطباً بذكر الله',
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 24),

                // Progress Section
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'تقدمك اليوم',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            '$completedCount / ${adhkar.length}',
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: completedCount / adhkar.length,
                          minHeight: 8,
                          backgroundColor: Colors.white24,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(
                            AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  'الأذكار (${adhkar.length})',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Dhikr Cards
                ...List.generate(adhkar.length, (index) {
                  final item = adhkar[index];

                  return DhikrCard(
                    dhikr: item.text,
                    repeat: item.repeat,
                    source: item.source,
                    currentCount: counters[index],
                    cardColor: cardColor,
                    textColor: textColor,
                    subtitleColor: subtitleColor,
                    borderColor: borderColor,
                    onTap: () => incrementCounter(index),
                  );
                }),
              ],
            ),
    );
  }
}

// ================= DHIKR CARD =================

class DhikrCard extends StatelessWidget {
  final String dhikr;
  final int repeat;
  final String source;
  final int currentCount;

  final Color cardColor;
  final Color textColor;
  final Color subtitleColor;
  final Color borderColor;

  final VoidCallback onTap;

  const DhikrCard({
    super.key,
    required this.dhikr,
    required this.repeat,
    required this.source,
    required this.currentCount,
    required this.cardColor,
    required this.textColor,
    required this.subtitleColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = currentCount >= repeat;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Repeat Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$repeat مرات',
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Dhikr Text
          Center(
            child: Text(
              dhikr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                height: 1.8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Source
          Center(
            child: Text(
              source,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subtitleColor,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Button and Counter
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: isCompleted ? null : onTap,
                icon: Icon(
                  isCompleted ? Icons.check : Icons.add,
                  size: 18,
                ),
                label: Text(
                  isCompleted ? 'مكتمل' : 'سبّح',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppColors.primary.withValues(alpha: 0.75),
                  disabledForegroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$currentCount / $repeat',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
