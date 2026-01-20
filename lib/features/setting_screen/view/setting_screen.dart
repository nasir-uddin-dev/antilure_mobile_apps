import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:antilure_mobile_apps/features/setting_screen/widgets/safety_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: [
          AppBarWidget(
            title: "Safety Mode",
            subTitle: "Controll your basic safety settings",
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafetyBoxWidget(
                    icon: Icons.safety_check,
                    iconColor: Color(0xFF2FA4E7),
                    iconBackgroundColor: Colors.white,
                    title: "Standard",
                    subTitle:
                        "Default protection, Standard text size and reporting features",
                  ),
                  SizedBox(height: 16.h),
                  SafetyBoxWidget(
                    icon: Icons.person,
                    iconColor: Colors.green,
                    iconBackgroundColor: Color(0xFFF0FDF4),
                    title: "Senor",
                    subTitle:
                        "Optimized for visibility. Larger text sizes and simplified terminology",
                  ),
                  SizedBox(height: 16.h),
                  SafetyBoxWidget(
                    icon: Icons.emoji_emotions,
                    iconColor: Colors.red,
                    iconBackgroundColor: Color(0xFFFFF7ED),
                    title: "Child",
                    subTitle:
                        "Safe browsing. Extra warnings on external links and no data monotoring",
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: customButton(text: "Save Preference", onTap: () {}),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
