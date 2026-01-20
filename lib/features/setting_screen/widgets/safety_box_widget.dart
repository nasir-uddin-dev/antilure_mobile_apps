import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SafetyBoxWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String subTitle;
  const SafetyBoxWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
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
        child: ListTile(
          leading: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Icon(icon, size: 24.sp, color: iconColor),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color(0xFF070707),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Color(0xFF4A4C56),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
          trailing: Radio(value: ()),
        ),
      ),
    );
  }
}
