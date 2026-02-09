import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isIconPresent;
  final List<Widget>? actions;
  final int notificationCount;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.isIconPresent = false,
    this.actions,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE9E9EA),
            spreadRadius: 0.5,
            blurRadius: 0.3,
          ),
        ],
      ),
      child: ListTile(
        leading: isIconPresent
            ? GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 24.sp,
                  color: Colors.black,
                ),
              )
            : null,
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
        trailing: actions != null && actions!.isNotEmpty
            ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
            : Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: Badge(
                    isLabelVisible: notificationCount > 0,
                    label: Text(
                      notificationCount > 99 ? "99+" : "$notificationCount",
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                      size: 26.sp,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
