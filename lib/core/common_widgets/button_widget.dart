import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton({required String text}) {
  return Container(
    width: double.infinity,
    height: 56.h,
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
    decoration: BoxDecoration(
      color: Color(0xFF2FA4E7),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget borderButton({required String text}) {
  return Container(
    width: double.infinity,
    height: 56.h,
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: Colors.grey.shade200, width: 1),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
