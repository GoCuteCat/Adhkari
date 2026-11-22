
import 'package:flutter/material.dart';

class AdhkarCategoryScreen extends StatelessWidget {
  final String categoryTitle;

  const AdhkarCategoryScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: const Center(
        child: Text('سيتم إضافة الأذكار هنا'),
      ),
    );
  }
}
