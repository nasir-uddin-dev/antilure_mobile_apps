import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class Page3Widget extends StatelessWidget {
  const Page3Widget ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        color: Color(0xFFEAF6FD),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: Container(
                        width: 80.r,
                        height: 80.r,
                        decoration: BoxDecoration(
                          color: Color(0xFFBFE3F8),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Icon(
                          Ionicons.hand_left,
                          size: 50.r,
                          color: Color(0xFF2FA4E7),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  "You did the right thing",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF070707),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Messages like this often try to steal personal or financial information",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: Color(0xFF4A4C56)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Color(0xFFFEECEE),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Color(0xFFF7B1B8), width: 1),
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
                  "Do not:",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF070707),
                  ),
                ),
                SizedBox(height: 8.h),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFFBD8DB),
                    radius: 25.r,
                  ),
                  title: Text(
                    "Click link in the message",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF4A4C56),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFFBD8DB),
                    radius: 25.r,
                  ),
                  title: Text(
                    "Reply to the message",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF4A4C56),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFFBD8DB),
                    radius: 25.r,
                  ),
                  title: Text(
                    "Share personal details or codes",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF4A4C56),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
