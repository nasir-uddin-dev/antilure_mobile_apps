import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/features/home_screen/widgets/scams_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
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
                        leading: Image.asset(
                          "assets/images/home_img.png",
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
                children: [
                  ScamsBoxWidget(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.checkLinkScreen,
                    ),
                    title: "Check a Link",
                    subTitle: "Paste a URL to see if it's safe",
                    icon: Icon(
                      Ionicons.link_outline,
                      size: 32.sp,
                      color: Color(0xFF2FA4E7),
                    ),
                  ),
                  ScamsBoxWidget(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.scanQrCodeScreen,
                    ),
                    title: "Scan QR Code",
                    subTitle: "Safely scan QR codes before opening them",
                    icon: Icon(
                      Ionicons.qr_code_outline,
                      size: 32.sp,
                      color: Color(0xFF4145EF),
                    ),
                  ),
                  ScamsBoxWidget(
                    onTap: () {},
                    title: "I Think This Is a Scam",
                    subTitle: "Get step-by-step guidance if you suspect fraud",
                    icon: Icon(
                      Ionicons.alert_outline,
                      size: 32.sp,
                      color: Color(0xFFF97316),
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
