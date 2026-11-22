
import 'package:flutter/material.dart';

import '../widgets/home_header.dart';
import '../widgets/category_card.dart';
import '../../adhkar/screens/adhkar_category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'أذكار الصباح',
        'subtitle': 'ابدأ يومك بذكر الله',
        'icon': Icons.wb_sunny_outlined,
      },
      {
        'title': 'أذكار المساء',
        'subtitle': 'اختم يومك بذكر الله',
        'icon': Icons.nights_stay_outlined,
      },
      {
        'title': 'أذكار بعد الصلاة',
        'subtitle': 'أذكار تحافظ عليها بعد كل صلاة',
        'icon': Icons.mosque_outlined,
      },
      {
        'title': 'أذكار النوم والاستيقاظ',
        'subtitle': 'أذكار قبل النوم وعند الاستيقاظ',
        'icon': Icons.bedtime_outlined,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أذكاري',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const HomeHeader(),
            const SizedBox(height: 28),
            Text(
              'الأذكار',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            ...categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CategoryCard(
                  title: category['title'] as String,
                  subtitle: category['subtitle'] as String,
                  icon: category['icon'] as IconData,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdhkarCategoryScreen(
                          categoryTitle: category['title'] as String,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
