import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/models/safety_mode.dart';
import 'package:antilure_mobile_apps/core/provider/safety_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(safetyModeProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: [
          AppBarWidget(
            title: "Safety Mode",
            subTitle: "Control your basic safety settings",
            notificationCount: 1,
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  _buildModeCard(
                    context,
                    ref,
                    mode: SafetyMode.standard,
                    title: "Standard",
                    subtitle:
                        "Default protection. Standard text size and reporting features",
                    icon: Icons.safety_check,
                    iconColor: Color(0xFF2FA4E7),
                    backgroundColor: Colors.white,
                    isSelected: currentMode == SafetyMode.standard,
                  ),
                  SizedBox(height: 16.h),
                  _buildModeCard(
                    context,
                    ref,
                    mode: SafetyMode.senior,
                    title: "Senior",
                    subtitle:
                        "Optimized for visibility. Larger text sizes and simplified terminology",
                    icon: Icons.person,
                    iconColor: Colors.green,
                    backgroundColor: Color(0xFFF0FDF4),
                    isSelected: currentMode == SafetyMode.senior,
                  ),
                  SizedBox(height: 16.h),
                  _buildModeCard(
                    context,
                    ref,
                    mode: SafetyMode.childLight,
                    title: "Child-Light",
                    subtitle:
                        "Safe browsing. Extra warnings on external links and no data monitoring",
                    icon: Icons.emoji_emotions,
                    iconColor: Color(0xFFF97316),
                    backgroundColor: Color(0xFFFFF7ED),
                    isSelected: currentMode == SafetyMode.childLight,
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAF6FD),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Color(0xFF2FA4E7),
                          size: 32.sp,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Safety Mode Info',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF070707),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'This setting only affects text size and wording level. Your selection is saved automatically.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF4A4C56),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context,
    WidgetRef ref, {
    required SafetyMode mode,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        ref.read(safetyModeProvider.notifier).setSafetyMode(mode);
        Fluttertoast.showToast(
          msg: 'Safety mode updated to $title',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF2FA4E7),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Color(0xFF2FA4E7) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Icon(icon, size: 28.sp, color: iconColor),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF070707),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14.sp, color: Color(0xFF4A4C56)),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Color(0xFF2FA4E7), size: 28.sp),
          ],
        ),
      ),
    );
  }
}
