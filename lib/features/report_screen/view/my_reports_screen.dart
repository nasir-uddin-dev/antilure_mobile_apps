import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/models/scam_report.dart';
import 'package:antilure_mobile_apps/core/provider/scam_report_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class MyReportsScreen extends ConsumerWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(scamReportProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            title: "My Reports",
            subTitle: "View and manage your saved scam reports",
            notificationCount: 3,
          ),
          Expanded(
            child: reports.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 64.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No reports yet',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Report scams to keep track of them',
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return _buildReportCard(context, ref, report);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCategoryDialog(context, ref),
        backgroundColor: Color(0xFF2FA4E7),
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('New Report', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildReportCard(
    BuildContext context,
    WidgetRef ref,
    ScamReport report,
  ) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  report.getCategoryName(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF070707),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _confirmDelete(context, ref, report.id),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            report.description,
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF4A4C56)),
          ),
          if (report.linkOrPhone != null) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                report.linkOrPhone!,
                style: TextStyle(fontSize: 12.sp, color: Color(0xFF6B7280)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          SizedBox(height: 8.h),
          Text(
            dateFormat.format(report.dateTime),
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showCategoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCategoryOption(
              context,
              ref,
              'Suspicious SMS',
              ScamCategory.suspiciousSMS,
            ),
            _buildCategoryOption(
              context,
              ref,
              'Phone Call Scam',
              ScamCategory.phoneCall,
            ),
            _buildCategoryOption(
              context,
              ref,
              'Fake Delivery',
              ScamCategory.fakeDelivery,
            ),
            _buildCategoryOption(
              context,
              ref,
              'Social Media Scam',
              ScamCategory.socialMedia,
            ),
            _buildCategoryOption(
              context,
              ref,
              'Email Scam',
              ScamCategory.email,
            ),
            _buildCategoryOption(context, ref, 'Other', ScamCategory.other),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryOption(
    BuildContext context,
    WidgetRef ref,
    String title,
    ScamCategory category,
  ) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        _showReportDialog(context, ref, category);
      },
    );
  }

  void _showReportDialog(
    BuildContext context,
    WidgetRef ref,
    ScamCategory category,
  ) {
    final descriptionController = TextEditingController();
    final linkOrPhoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report ${category.toString().split('.').last}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'What happened?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: linkOrPhoneController,
                decoration: InputDecoration(
                  labelText: 'Link or Phone (Optional)',
                  hintText: 'Suspicious link or phone number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (descriptionController.text.trim().isNotEmpty) {
                final report = ScamReport(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  category: category,
                  description: descriptionController.text.trim(),
                  linkOrPhone: linkOrPhoneController.text.trim().isNotEmpty
                      ? linkOrPhoneController.text.trim()
                      : null,
                  dateTime: DateTime.now(),
                );
                ref.read(scamReportProvider.notifier).addReport(report);
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: 'Report saved locally',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xFF2FA4E7),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2FA4E7)),
            child: Text('Save Report', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Report'),
        content: Text('Are you sure you want to delete this report?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(scamReportProvider.notifier).deleteReport(id);
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: 'Report deleted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
