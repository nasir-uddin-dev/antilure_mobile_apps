import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/core/provider/link_checker_provider.dart';
import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';
import 'package:antilure_mobile_apps/core/utils/threat_level_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

class CheckLinkScreen extends ConsumerStatefulWidget {
  const CheckLinkScreen({super.key});

  @override
  ConsumerState<CheckLinkScreen> createState() => _CheckLinkScreenState();
}

class _CheckLinkScreenState extends ConsumerState<CheckLinkScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pasteFromClipboard() async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      _controller.text = clipboardData.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final linkCheckState = ref.watch(linkCheckerProvider);

    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            title: 'Check a Link',
            subTitle: "Paste a URL to see if it's safe",
            notificationCount: 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  /// Input Container
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
                              suffixIcon: IconButton(
                                icon: Text(
                                  "PASTE",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xFF2FA4E7),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: _pasteFromClipboard,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE9E9EA),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF2FA4E7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          linkCheckState.isLoading
                              ? CircularProgressIndicator()
                              : customButton(
                                  text: "Check Link",
                                  onTap: () {
                                    if (_controller.text.trim().isNotEmpty) {
                                      ref
                                          .read(linkCheckerProvider.notifier)
                                          .checkLink(_controller.text.trim());
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: 'Please enter a valid URL',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  /// Analysis Result
                  if (linkCheckState.result != null) ...[
                    Container(
                      padding: EdgeInsets.all(24.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ThreatLevelHelper.getBackgroundColor(
                          linkCheckState.result!.threatLevel,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: ThreatLevelHelper.getThreatColor(
                            linkCheckState.result!.threatLevel,
                          ),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48.r,
                                height: 48.r,
                                decoration: BoxDecoration(
                                  color: ThreatLevelHelper.getThreatColor(
                                    linkCheckState.result!.threatLevel,
                                  ).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Icon(
                                  ThreatLevelHelper.getThreatIcon(
                                    linkCheckState.result!.threatLevel,
                                  ),
                                  color: ThreatLevelHelper.getThreatColor(
                                    linkCheckState.result!.threatLevel,
                                  ),
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      linkCheckState.result!.message,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ThreatLevelHelper.getThreatColor(
                                          linkCheckState.result!.threatLevel,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Risk Score: ${linkCheckState.result!.riskScore.toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            linkCheckState.result!.description,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                          ),
                          if (linkCheckState
                              .result!
                              .detectedThreats
                              .isNotEmpty) ...[
                            SizedBox(height: 16.h),
                            Text(
                              'Detected Issues:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            ...linkCheckState.result!.detectedThreats.map(
                              (threat) => Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.warning_amber,
                                      size: 18.sp,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        threat,
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 16.h),
                          if (linkCheckState.result!.threatLevel ==
                              ThreatLevel.low)
                            customButton(
                              text: "Open Link in Safe Browser",
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.webViewScreen,
                                  arguments: {
                                    'url': linkCheckState.result!.url,
                                    'title': 'Safe Link',
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  /// Info Box
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
                        Expanded(
                          child: Column(
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
                                "You can also scan QR codes directly with your camera to check for malicious links",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF4A4C56),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
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
