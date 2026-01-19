import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: [
          AppBarWidget(
            title: 'Scan QR Code',
            subTitle: "Point your camera at a QR code to check it",
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  Container(
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 24.h,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Align QR code within frame",
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: Color(0xFF070707),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            textAlign: TextAlign.center,
                            "Point your camera at a QR code to\ncheck if it's safe.",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF4A4C56),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Image.asset("assets/images/qr_code_img.png"),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 77.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF7ED),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Ionicons.alert_outline,
                          color: Colors.red,
                        ),
                        title: Text(
                          "CAUTION RECOMMENDED",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Color(0xFF961000),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "http://suspicious-sit.com/login",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF4A4C56),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "The link is reported as a potential\npublishing attempt",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xFF070707),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            spacing: 10.w,
                            children: [
                              Expanded(child: customButton(text: "Go Back")),
                              Expanded(child: borderButton(text: "Proceed")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
