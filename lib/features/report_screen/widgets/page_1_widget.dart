import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class page_1_widget extends StatelessWidget {
  const page_1_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              color: Color(0xFFEAF6FD),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Icon(Icons.message, size: 50.r, color: Color(0xFF2FA4E7)),
          ),
          SizedBox(height: 16.h),
          Text(
            "Stop and take a breath",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF070707),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Don't click any links in the message. Take a moment to calm down. Scammers want you to panic and act fast",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, color: Color(0xFF4A4C56)),
          ),
        ],
      ),
    );
  }
}
