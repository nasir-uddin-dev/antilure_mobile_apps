import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBoxWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subTitle;

  const MessageBoxWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 127.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ListTile(
        leading: Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: Color(0xFFEAF6FD),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: icon,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                color: Color(0xFF070707),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xFF4A4C56),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          height: 70.h,
          child: Switch(value: true, onChanged: (bool) {}),
        ),
      ),
    );
  }
}
