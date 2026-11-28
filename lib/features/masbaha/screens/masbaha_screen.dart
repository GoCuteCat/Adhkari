import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import 'masbaha_counter_circle.dart';

/// Digital tasbeeh (masbaha) screen.
///
/// Note: this screen is UI only (layout, no logic).
/// Every place marked TODO(teammate) is functionality that another
/// teammate will implement.
/// i've already implemented the UI .
class MasbahaScreen extends StatefulWidget {
  const MasbahaScreen({super.key});

  @override
  State<MasbahaScreen> createState() => _MasbahaScreenState();
}

class _MasbahaScreenState extends State<MasbahaScreen> {
//  _MasbahaScreenState({super.key});

  // ---------------------------------------------------------------------------
  // Hardcoded display-only values (placeholders).
  // They will be replaced with real values once the logic is added.
  // ---------------------------------------------------------------------------
  static String _currentDhikr = 'سبحان الله';
  static int  _count = 0;
  static int _target = 33;
  static  int _rounds = 0;
  static  int _todayTotal = 154;
  static const List<String> _targets = ['33', '100', '1000', 'حر'];
  static int _selectedTargetIndex = 0;
  static const List<String> _adhkar = [
  'سبحان الله',
  'الحمد لله',
  'الله أكبر',
  'لا إله إلا الله',
  'أستغفر الله',
  'لا حول ولا قوة إلا بالله',
  'اللهم صل وسلم على نبينا محمد',
];

  // ---------------------------------------------------------------------------
  // These handlers are intentionally empty
  // ---------------------------------------------------------------------------

  // TODO(teammate): increment the counter by 1 when the button is tapped
  // Increment counter
void _onTapCount() {
  setState(() {
    _count++;
    _todayTotal++;

    // Check if target is completed
    if (_target > 0 && _count >= _target) {
      _rounds++;
      _count = 0;
    }
  });
}

  // TODO(teammate): reset the counter
  void _onReset() {
  setState(() {
    _count = 0;
    _rounds = 0;
  });
}


  // TODO(teammate): select the current dhikr from a list
  void _onSelectDhikr() {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'اختار الذكر',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            ..._adhkar.map((dhikr) {
              return ListTile(
                title: Text(
                  dhikr,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  setState(() {
                    _currentDhikr = dhikr;
                    _count = 0;
                    _rounds = 0;
                  });

                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      );
    },
  );
}

  // TODO(teammate): change the round target (33 / 100 / 1000 / free)
 void _onSelectTarget(int index) {
  setState(() {
    _selectedTargetIndex = index;

    switch (index) {
      case 0:
        _target = 33;
        break;

      case 1:
        _target = 100;
        break;

      case 2:
        _target = 1000;
        break;

      case 3:
        _target = 0; // Free counting
        break;
    }

    _count = 0;
    _rounds = 0;
  });
}

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).colorScheme.surface;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xFFE6E3DA);
    final subtitleColor =
        isDark ? AppColors.subtitleDark : AppColors.subtitleLight;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'السبحة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            // ----- Today's total count -----
            _InfoCard(
              color: cardColor,
              borderColor: borderColor,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.spa_outlined, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مجموع تسبيحات اليوم',
                        style: TextStyle(color: subtitleColor, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_todayTotal',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ----- Current dhikr -----
            _InfoCard(
              color: cardColor,
              borderColor: borderColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الذكر الحالي:',
                    style: TextStyle(color: subtitleColor, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _onSelectDhikr,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _currentDhikr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ----- Round target -----
            Text(
              'الهدف المحدد للدورة:',
              style: TextStyle(color: subtitleColor, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(_targets.length, (i) {
                final selected = i == _selectedTargetIndex;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: i == _targets.length - 1 ? 0 : 8,
                    ),
                    child: InkWell(
                      onTap: () => _onSelectTarget(i),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected ? AppColors.primary : cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected ? AppColors.primary : borderColor,
                          ),
                        ),
                        child: Text(
                          _targets[i],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selected ? Colors.white : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 28),

            // ----- Circular counter -----
            Center(
              child: MasbahaCounterCircle(
                dhikr: _currentDhikr,
                count: _count,
                target: _target,
                rounds: _rounds,
              ),
            ),
            const SizedBox(height: 28),

            // ----- Tap / count button -----
            SizedBox(
              height: 64,
              child: FilledButton(
                onPressed: _onTapCount,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text(
                  'سبّح',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ----- Reset button -----
            Center(
              child: TextButton.icon(
                onPressed: _onReset,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة تصفير'),
                style: TextButton.styleFrom(foregroundColor: subtitleColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bordered card, same style as the cards on the home screen.
class _InfoCard extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Widget child;

  const _InfoCard({
    required this.color,
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}