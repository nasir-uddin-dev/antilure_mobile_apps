import 'package:antilure_mobile_apps/features/report_screen/widgets/build_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class page_2_widget extends StatelessWidget {
  const page_2_widget({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What was the message about?",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF070707),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Select the option that best matches",
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
                children: [
                  BuildOptions(
                    title: "Package delivery issue",
                    subTitle: "Missed delivery, tracking, or shipping fee",  icon: Icons.delivery_dining,
                  ),
                  SizedBox(height: 16.h),
                  BuildOptions(
                    title: "Bank or payment alert",
                    subTitle: "Account frozen, suspicious activity",  icon: Icons.payment_outlined,
                  ),
                  SizedBox(height: 16.h),
                  BuildOptions(
                    title: "Prize, reward, or refund",
                    subTitle: "You've won something or money owed",  icon: Icons.book,
                  ),
                  SizedBox(height: 16.h),
                  BuildOptions(
                    title: "Message with a link",
                    subTitle: "Contains a website or URL", icon: Icons.link,
                  ),
                  SizedBox(height: 16.h),
                  BuildOptions(
                    title: "Something else",
                    subTitle: "Doesn't fit the above", icon: Icons.question_mark_outlined,
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
