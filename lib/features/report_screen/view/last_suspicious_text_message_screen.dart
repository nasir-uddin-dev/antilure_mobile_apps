import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class LastSuspiciousTextMessageScreen extends StatefulWidget {
  const LastSuspiciousTextMessageScreen({super.key});

  @override
  State<LastSuspiciousTextMessageScreen> createState() =>
      _LastSuspiciousTextMessageScreenState();
}

class _LastSuspiciousTextMessageScreenState
    extends State<LastSuspiciousTextMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: [
          AppBarWidget(
            title: "Suspicious Text Message",
            subTitle: "Got a strange text message?",
            notificationCount: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
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
                                  Ionicons.checkmark,
                                  size: 50.r,
                                  color: Color(0xFF2FA4E7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Report sent",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Color(0xFF070707),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          textAlign: TextAlign.center,
                          "Your report helps prevent scams and protects our community",
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: customButton(
                      text: "Done",
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.reportScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          Spacer(),
        ],
      ),
    );
  }
}
