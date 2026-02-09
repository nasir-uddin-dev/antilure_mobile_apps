import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/features/report_screen/widgets/page_1_widget.dart';
import 'package:antilure_mobile_apps/features/report_screen/widgets/page_2_widget.dart';
import 'package:antilure_mobile_apps/features/report_screen/widgets/page_3_widget.dart';
import 'package:antilure_mobile_apps/features/report_screen/widgets/page_4_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ------------- Create this provider in your providers directory -------------
final suspiciousTextPageProvider = StateProvider<int>((ref) => 0);

class SuspiciousTextMessageScreen extends ConsumerStatefulWidget {
  const SuspiciousTextMessageScreen({super.key});

  @override
  ConsumerState<SuspiciousTextMessageScreen> createState() =>
      _SuspiciousTextMessageScreenState();
}

class _SuspiciousTextMessageScreenState
    extends ConsumerState<SuspiciousTextMessageScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final currentPage = ref.read(suspiciousTextPageProvider);
    if (currentPage < 3) {
      /// --------------- Changed from 1 to 3 (0-3 = 4 pages) ------------------
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      ref.read(suspiciousTextPageProvider.notifier).state = currentPage + 1;
      debugPrint("=========== Next page ${currentPage + 1}============");
    }
  }

  void _previousPage() {
    final currentPage = ref.read(suspiciousTextPageProvider);
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      ref.read(suspiciousTextPageProvider.notifier).state = currentPage - 1;
      debugPrint("=========== Previous page ${currentPage - 1}============");
    }
  }

  void _submitReport() {
    /// Handle report submission
    debugPrint("Submitting report...");
    Navigator.pushNamed(context, RouteNames.lastSuspiciousTextMessageScreen);
  }

  @override
  Widget build(BuildContext context) {
    ///  ------------- Watch the page provider to rebuild when page changes ----
    final currentPage = ref.watch(suspiciousTextPageProvider);

    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            title: "Suspicious Text Message",
            subTitle: "Got a strange text message?",
            notificationCount: 2,
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step ${currentPage + 1} of 4",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  color: Color(0xFF2FA4E7),
                  backgroundColor: Color(0xFFD2D2D5),
                  value: (currentPage + 1) / 4,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 600.h,
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (page) {
                        /// -------- Update Riverpod state when page changes ---
                        ref.read(suspiciousTextPageProvider.notifier).state =
                            page;
                      },
                      children: [
                        // Page 1
                        Page1Widget(),
                        // Page 2
                        Page2Widget(),
                        // Page 3
                        Page3Widget(),
                        // Page 4
                        Page4Widget(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    width: double.infinity,
                    child: _buildBottomButtons(currentPage),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(int currentPage) {
    ///------------ On last page (step 4), show only "Submit Report" button-----
    if (currentPage == 3) {
      return customButton(text: "Submit Report", onTap: _submitReport);
    }

    ///------------- On other pages, show Previous and Next buttons ------------
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: borderButton(text: "Previous", onTap: _previousPage),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: customButton(text: "Next", onTap: _nextPage),
          ),
        ),
      ],
    );
  }
}
