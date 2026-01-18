import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckLinkScreen extends StatelessWidget {
  const CheckLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
            ),
          ],
        ),
      ),
    );
  }
}
