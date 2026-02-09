import 'package:antilure_mobile_apps/core/provider/bottom_navigation_provider/navigation_provider.dart';
import 'package:antilure_mobile_apps/features/home_screen/view/home_screen.dart';
import 'package:antilure_mobile_apps/features/report_screen/view/report_screen.dart';
import 'package:antilure_mobile_apps/features/setting_screen/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../history_screen/view/history_screen.dart';

class ParentScreen extends ConsumerStatefulWidget {
  const ParentScreen({super.key});

  @override
  ConsumerState<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends ConsumerState<ParentScreen> {
  ///--------------- list of pages to display ----------------------------------
  final List<Widget> _pages = [
    HomeScreen(),
    ReportScreen(),
    HistoryScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    /// -------- Watch the current index from the provider ---------------------
    final currentIndex = ref.watch(currentIndexProvider);
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 112.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          selectedIconTheme: IconThemeData(color: Color(0xFF2FA4E7)),
          selectedItemColor: Color(0xFF2FA4E7),
          onTap: (index) {
            ref.read(currentIndexProvider.notifier).state = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.file_tray),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.timer_outline),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.settings_outline),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
