import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Shell مع Bottom Navigation — يُغلّف الشاشات الرئيسية الأربع
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (i) {
          // Haptic feedback عند الضغط
          HapticFeedback.lightImpact();

          if (i == navigationShell.currentIndex) {
            // الضغط على نفس التبويب → scroll للأعلى إذا أمكن
            // go_router يُعيد تحميل الـ branch من أوله
            navigationShell.goBranch(i, initialLocation: true);
          } else {
            navigationShell.goBranch(i, initialLocation: false);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'الدورات',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school_rounded),
            label: 'دوراتي',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'حسابي',
          ),
        ],
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: theme.colorScheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        animationDuration: const Duration(milliseconds: 300),
        elevation: 8,
        shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.15),
      ),
    );
  }
}
