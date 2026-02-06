import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/features/report_screen/widgets/message_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: [
          /// ----------------------- App Bar ----------------------------------
          AppBarWidget(
            isIconPresent: false,
            title: "I Think This Is a Scam",
            subTitle: "Get step-by-step guidance.",
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    width: double.infinity,
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
                      children: [
                        Text(
                          "What's Happening",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Color(0xFF070707),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          textAlign: TextAlign.center,
                          "Choose the situation that best matches what\nyou're experiencing",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color(0xFF4A4C56),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.suspiciousTextMessageScreen,
                      );
                    },
                    child: MessageBoxWidget(
                      icon: Icon(
                        Ionicons.chatbox_outline,
                        color: Colors.blue.shade600,
                      ),
                      title: "Suspicious Text Message",
                      subTitle:
                          "Got a strange text about a package,bank, or prize?",
                    ),
                  ),
                  SizedBox(height: 10.h),
                  MessageBoxWidget(
                    icon: Icon(
                      Icons.phone_outlined ,
                      color: Colors.blue.shade600,
                    ),
                    title: "Suspicious Phone Call",
                    subTitle:
                        "Someone calling about taxes, tech support, or your accout?",
                  ),
                  SizedBox(height: 10.h),
                  MessageBoxWidget(
                    icon: Icon(
                      Icons.phone_android_outlined,
                      color: Colors.blue.shade600,
                    ),
                    title: "Fake Delivery Message",
                    subTitle:
                        "Message about a package you need to pay for or reschedule?",
                  ),
                  SizedBox(height: 10.h),
                  MessageBoxWidget(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.blue.shade600,
                    ),
                    title: "Social Media Scam",
                    subTitle:
                        "Friend asking for money or a too good to be true offer?",
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
