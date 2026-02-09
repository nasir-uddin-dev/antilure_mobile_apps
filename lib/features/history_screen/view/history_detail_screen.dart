import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';
import 'package:antilure_mobile_apps/core/utils/threat_level_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class HistoryDetailScreen extends StatelessWidget {
  final LinkAnalysisResult result;

  const HistoryDetailScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM dd, yyyy • hh:mm a');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarWidget(
            title: "Scan Details",
            subTitle: "Detailed threat analysis",
            isIconPresent: true,
            notificationCount: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Threat Level Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: ThreatLevelHelper.getBackgroundColor(
                        result.threatLevel,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: ThreatLevelHelper.getThreatColor(
                          result.threatLevel,
                        ),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80.r,
                          height: 80.r,
                          decoration: BoxDecoration(
                            color: ThreatLevelHelper.getThreatColor(
                              result.threatLevel,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Icon(
                            ThreatLevelHelper.getThreatIcon(result.threatLevel),
                            color: ThreatLevelHelper.getThreatColor(
                              result.threatLevel,
                            ),
                            size: 40.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          result.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ThreatLevelHelper.getThreatColor(
                              result.threatLevel,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            'Risk Score: ${result.riskScore.toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ThreatLevelHelper.getThreatColor(
                                result.threatLevel,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          result.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Scan Time
                  _buildInfoSection(
                    'Scan Time',
                    dateFormat.format(result.scanTime),
                    Icons.schedule,
                  ),
                  SizedBox(height: 16.h),

                  // URL Section
                  _buildInfoSection(
                    'Scanned URL',
                    result.url,
                    Icons.link,
                    isUrl: true,
                    context: context,
                  ),
                  SizedBox(height: 16.h),

                  // Threat Level
                  _buildInfoSection(
                    'Threat Level',
                    ThreatLevelHelper.getThreatText(result.threatLevel),
                    Icons.shield,
                  ),
                  SizedBox(height: 24.h),

                  // Detected Threats
                  if (result.detectedThreats.isNotEmpty) ...[
                    Text(
                      'Detected Issues (${result.detectedThreats.length})',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF7ED),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        children: result.detectedThreats.map((threat) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  size: 20.sp,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    threat,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Color(0xFFE9FAF3),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'No threats detected in this scan',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],

                  // Action Button - Open in WebView if safe
                  if (result.threatLevel == ThreatLevel.low)
                    customButton(
                      text: "Open Link in Safe Browser",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.webViewScreen,
                          arguments: {
                            'url': result.url,
                            'title': 'History Link',
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    String title,
    String content,
    IconData icon, {
    bool isUrl = false,
    BuildContext? context,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.sp, color: Color(0xFF6B7280)),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isUrl && context != null)
                IconButton(
                  icon: Icon(Icons.copy, size: 20.sp),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: content));
                    Fluttertoast.showToast(
                      msg: 'URL copied to clipboard',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
