import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/core/provider/link_checker_provider.dart';
import 'package:antilure_mobile_apps/core/utils/threat_level_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            title: "Scan History",
            subTitle: "History of scanned links and QR codes",
            notificationCount: 5,
          ),
          Expanded(
            child: historyAsync.when(
              data: (history) {
                if (history.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 64.sp, color: Colors.grey),
                        SizedBox(height: 16.h),
                        Text(
                          'No scan history yet',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Start scanning links and QR codes',
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final result = history[index];
                    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.historyDetailScreen,
                          arguments: result,
                        );
                      },
                      child: Dismissible(
                        key: Key(result.url),
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.w),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                        ),
                        onDismissed: (direction) async {
                        
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: ThreatLevelHelper.getThreatColor(
                                result.threatLevel,
                              ).withOpacity(0.2),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Threat Icon
                              Container(
                                width: 48.r,
                                height: 48.r,
                                decoration: BoxDecoration(
                                  color: ThreatLevelHelper.getBackgroundColor(
                                    result.threatLevel,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  ThreatLevelHelper.getThreatIcon(
                                    result.threatLevel,
                                  ),
                                  color: ThreatLevelHelper.getThreatColor(
                                    result.threatLevel,
                                  ),
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            ThreatLevelHelper.getThreatText(
                                              result.threatLevel,
                                            ),
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  ThreatLevelHelper.getThreatColor(
                                                    result.threatLevel,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                ThreatLevelHelper.getBackgroundColor(
                                                  result.threatLevel,
                                                ),
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: Text(
                                            '${result.riskScore.toStringAsFixed(0)}%',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  ThreatLevelHelper.getThreatColor(
                                                    result.threatLevel,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      dateFormat.format(result.scanTime),
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      padding: EdgeInsets.all(10.r),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF9FAFB),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.link,
                                            size: 14.sp,
                                            color: Colors.grey[600],
                                          ),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              result.url,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (result.detectedThreats.isNotEmpty) ...[
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            size: 14.sp,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '${result.detectedThreats.length} issue${result.detectedThreats.length > 1 ? 's' : ''} detected',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.orange[700],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    SizedBox(height: 4.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Tap for details',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.blue[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12.sp,
                                          color: Colors.blue[600],
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
                    );
                  },
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64.sp, color: Colors.red),
                    SizedBox(height: 16.h),
                    Text(
                      'Error loading history',
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
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
