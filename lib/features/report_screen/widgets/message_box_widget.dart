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
    return ListTile(
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(color: Color(0xFFEAF6FD)),
        child: icon,
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
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      trailing: Column(
        children: [
          Switch(value: true, onChanged: (bool){})
        ],
      ),
    );
  }
}
