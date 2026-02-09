import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/features/home_screen/view/widgets/scams_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Color(0xFFF2F2F2),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  /// Display logo, text and notification inside container
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
              ///--------------------- Header section --------------------------
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
                    title: "Link Check",
                    subTitle: "Paste a URL to see if it's safe",
                    icon: Icon(
                      Ionicons.link_outline,
                      size: 32.sp,
                      color: Color(0xFF2FA4E7),
                    ),
                    color: Color(0xFFEAF6FD),
                  ),
                  ScamsBoxWidget(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.scanQrCodeScreen,
                    ),
                    title: "QR Scanner",
                    subTitle: "Scan QR codes safely before opening",
                    icon: Icon(
                      Ionicons.qr_code_outline,
                      size: 32.sp,
                      color: Color(0xFF4145EF),
                    ),
                    color: Color(0xFFEEF2FF),
                  ),
                  ScamsBoxWidget(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.helpNowScreen,
                    ),
                    title: "Help Now",
                    subTitle: "Get step-by-step guidance if you suspect fraud",
                    icon: Icon(
                      Ionicons.alert_outline,
                      size: 32.sp,
                      color: Color(0xFFF97316),
                    ),
                    color: Color(0xFFFFF7ED),
                  ),
                  ScamsBoxWidget(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.reportScreen,
                    ),
                    title: "Report Scam",
                    subTitle: "Save a scam incident to your local records",
                    icon: Icon(
                      Ionicons.warning_outline,
                      size: 32.sp,
                      color: Color(0xFFDC2626),
                    ),
                    color: Color(0xFFFFEDED),
                  ),
                  ScamsBoxWidget(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.myReportsScreen,
                    ),
                    title: "My Reports",
                    subTitle: "View all your saved scam reports",
                    icon: Icon(
                      Ionicons.document_text_outline,
                      size: 32.sp,
                      color: Color(0xFF10B981),
                    ),
                    color: Color(0xFFE9FAF3),
                  ),
                  ScamsBoxWidget(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.settingScreen,
                    ),
                    title: "Safety Mode",
                    subTitle: "Adjust text size and display settings",
                    icon: Icon(
                      Ionicons.settings_outline,
                      size: 32.sp,
                      color: Color(0xFF6B7280),
                    ),
                    color: Color(0xFFF3F4F6),
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
