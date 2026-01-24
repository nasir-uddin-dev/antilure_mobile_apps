import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class CheckLinkScreen extends StatefulWidget {
  const CheckLinkScreen({super.key});

  @override
  State<CheckLinkScreen> createState() => _CheckLinkScreenState();
}

class _CheckLinkScreenState extends State<CheckLinkScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(title: 'Check a Link', subTitle: "Paste a URL to see if it's safe",),
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
                            "Is this link safe?",
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: Color(0xFF070707),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            textAlign: TextAlign.center,
                            "Paste any website address below and\nwe'll scan it for scams.",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF4A4C56),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.link),
                              suffixText: "PASTE",
                              suffixStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0xFF2FA4E7),
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE9E9EA),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE9E9EA),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          customButton(text: "Check Link", onTap: () {  }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(24.r),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9FAF3),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE9E9EA),
                          spreadRadius: 0.5,
                          blurRadius: 0.3,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.r,
                          height: 48.r,
                          decoration: BoxDecoration(
                            color: Color(0xFFD1FAE5),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Icon(Icons.safety_check, color: Colors.green),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "This link looks safe",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(0xFF070707),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "We scanned google.com and didn't find\nany known treats",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0xFF4A4C56),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(24.r),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE9E9EA),
                          spreadRadius: 0.5,
                          blurRadius: 0.3,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.r,
                          height: 48.r,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                            child: Icon(
                              Ionicons.qr_code_outline,
                              size: 24.sp,
                              color: Color(0xFF2FA4E7),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Did you know",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(0xFF070707),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "You can also scan QR codes directly\nwith your camera to check for\nmalicious link",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(0xFF4A4C56),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
