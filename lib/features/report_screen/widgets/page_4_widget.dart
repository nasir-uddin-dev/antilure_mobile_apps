import 'package:antilure_mobile_apps/features/report_screen/widgets/build_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Page4Widget extends StatelessWidget {
  const Page4Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Color(0xFFFFFFFF), width: 1),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE9E9EA),
                spreadRadius: 0.5,
                blurRadius: 0.3,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "What would you like to report?",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF070707),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Select what you'd like to share with us",
                style: TextStyle(fontSize: 16.sp, color: Color(0xFF4A4C56)),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
        // Options List
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildReport(title: "Phone number", icon: Icons.phone),
                  SizedBox(height: 16.h),
                  BuildReport(title: "Link or website", icon: Icons.link),
                  SizedBox(height: 16.h),
                  BuildReport(
                    title: "Prize, reward, or refund",
                    icon: Icons.qr_code,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Suspect Link",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Color(0xFF070707),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BuildReport(
                    title: "https://suspicious-site.com",
                    icon: Icons.link,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "What happened?",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Color(0xFF070707),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BuildReport(     
                    title: "Briefly describe the incident",
                    icon: Icons.link,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
