import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/history_box_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            title: "All History",
            subTitle: "History of links, scans, reports",
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Text(
                  "October 2025",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF777980),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HistoryBoxWidget(
                    icon: Icons.link,
                    iconColor: Color(0xFF2FA4E7),
                    iconBackgroundColor: Color(0xFFEAF6FD),
                    title: 'IRS Tax Rebate Link',
                    subTitle: 'Malicious Website',
                  ),
                  SizedBox(height: 16.h),
                  HistoryBoxWidget(
                    icon: Icons.phone,
                    iconColor: Color(0xFF2FA4E7),
                    iconBackgroundColor: Color(0xFFEAF6FD),
                    title: 'Fake Tech Support',
                    subTitle: 'Phone Call Scam',
                  ),
                  SizedBox(height: 16.h),
                  HistoryBoxWidget(
                    icon: Icons.chat,
                    iconColor: Color(0xFF2FA4E7),
                    iconBackgroundColor: Color(0xFFEAF6FD),
                    title: 'Package Delivery Scam',
                    subTitle: 'SMS Phishing',
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    "October 2025",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF777980),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  HistoryBoxWidget(
                    icon: Icons.qr_code,
                    iconColor: Color(0xFF2FA4E7),
                    iconBackgroundColor: Color(0xFFEAF6FD),
                    title: 'Package Delivery Scam',
                    subTitle: 'SMS Phishing',
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
