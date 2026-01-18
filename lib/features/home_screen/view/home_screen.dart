import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> _items = [
    {
      'icon': Container(
        width: 64.r,
        height: 64.r,
        decoration: BoxDecoration(
          color: Color(0xFFEAF6FD),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Icon(
            Ionicons.link_outline,
            size: 32.sp,
            color: Color(0xFF2FA4E7),
          ),
        ),
      ),
      'title': "Check a Link",
      'subTitle': "Paste a URL to see if it's safe",
    },
    {
      'icon': Container(
        width: 64.r,
        height: 64.r,
        decoration: BoxDecoration(
          color: Color(0xFFEEF2FF),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Icon(
            Ionicons.qr_code_outline,
            size: 32.sp,
            color: Color(0xFF4F46E5),
          ),
        ),
      ),
      'title': "Scan QR Code",
      'subTitle': "Safely scan QR codes before opening them",
    },
    {
      'icon': Container(
        width: 64.r,
        height: 64.r,
        decoration: BoxDecoration(
          color: Color(0xFFFFF7ED),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Icon(
            Ionicons.alert_outline,
            size: 32.sp,
            color: Color(0xFFEA580C),
          ),
        ),
      ),
      'title': "I Think This Is a Scam",
      'subTitle': "Get step-by-step guidance if you suspect fraud",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Display logo, text and notification inside container
                  Container(
                    width: double.infinity,
                    height: 163.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF2FA4E7),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/flutter_logo.svg",
                          width: 50.r,
                          height: 50.r,
                        ),
                        title: Text(
                          "AntiLur",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                            child: Badge(
                              label: Text("2"),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Colors.black,
                                size: 26.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Header section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stay safe from scams",
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Color(0xFF070707),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Simple tools to protect yourself from fraud and\nsuspicious links",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF4A4C56),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h),
              child: Column(
                children: List.generate(_items.length, (int index) {
                  final item = _items[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.checkLinkScreen);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16.h),
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Color(0xFFE9E9EA)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          item['icon'] as Widget,
                          SizedBox(height: 16.h),
                          Text(
                            item['title'] as String,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xFF070707),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text(
                              item['subTitle'] as String,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0xFF4A4C56),
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
