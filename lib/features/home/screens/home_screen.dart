import 'package:flutter/material.dart';

import '../../../app/theme/theme_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/category_card.dart';
import '../../adhkar/screens/adhkar_category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<_CategoryItem> categories = [
    _CategoryItem(
      title: 'أذكار الصباح',
      subtitle: 'ابدأ يومك بذكر الله',
      icon: Icons.wb_sunny_outlined,
    ),
    _CategoryItem(
      title: 'أذكار المساء',
      subtitle: 'اختم يومك بذكر الله',
      icon: Icons.nights_stay_outlined,
    ),
    _CategoryItem(
      title: 'أذكار بعد الصلاة',
      subtitle: 'أذكار ما بعد الصلوات',
      icon: Icons.mosque_outlined,
    ),
    _CategoryItem(
      title: 'أذكار النوم والاستيقاظ',
      subtitle: 'أذكار قبل النوم وعند الاستيقاظ',
      icon: Icons.bedtime_outlined,
    ),
  ];

  void _openCategory(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdhkarCategoryScreen(categoryTitle: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, color: AppColors.secondary),
            SizedBox(width: 8),
            Text('أذكاري', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: Theme.of(context).brightness == Brightness.dark
                ? 'الوضع الفاتح'
                : 'الوضع الداكن',
            onPressed: themeController.toggleTheme,
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            const HomeHeader(),
            const SizedBox(height: 28),

            Text(
              'الأذكار اليومية',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'اختر القسم الذي تريد البدء به',
              style: TextStyle(
                color: isDark
                    ? AppColors.subtitleDark
                    : AppColors.subtitleLight,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 18),

            ...categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CategoryCard(
                  title: category.title,
                  subtitle: category.subtitle,
                  icon: category.icon,
                  onTap: () => _openCategory(context, category.title),
                ),
              );
            }),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppColors.borderDark
                      : const Color(0xFFE6E3DA),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.favorite_outline,
                    color: AppColors.accent,
                    size: 28,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'لا تنسَ ذكر الله',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'اجعل ذكر الله جزءًا من يومك.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _CategoryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
