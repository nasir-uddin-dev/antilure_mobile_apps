import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';
import 'package:antilure_mobile_apps/features/help_screen/view/help_now_screen.dart';
import 'package:antilure_mobile_apps/features/history_screen/view/history_detail_screen.dart';
import 'package:antilure_mobile_apps/features/home_screen/view/check_link_screen.dart';
import 'package:antilure_mobile_apps/features/home_screen/view/scan_qr_code_screen.dart';
import 'package:antilure_mobile_apps/features/home_screen/view/web_view_screen.dart';
import 'package:antilure_mobile_apps/features/parent_screen/parent_screen.dart';
import 'package:antilure_mobile_apps/features/report_screen/view/last_suspicious_text_message_screen.dart';
import 'package:antilure_mobile_apps/features/report_screen/view/my_reports_screen.dart';
import 'package:antilure_mobile_apps/features/report_screen/view/report_screen.dart';
import 'package:antilure_mobile_apps/features/report_screen/view/suspicious_text_message_screen.dart';
import 'package:antilure_mobile_apps/features/setting_screen/view/setting_screen.dart';
import 'package:antilure_mobile_apps/features/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../features/history_screen/view/history_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.checkLinkScreen: (context) => const CheckLinkScreen(),
    RouteNames.scanQrCodeScreen: (context) => const ScanQrCodeScreen(),
    RouteNames.reportScreen: (context) => const ReportScreen(),
    RouteNames.suspiciousTextMessageScreen: (context) =>
        const SuspiciousTextMessageScreen(),
    RouteNames.lastSuspiciousTextMessageScreen: (context) =>
        LastSuspiciousTextMessageScreen(),
    RouteNames.historyScreen: (context) => const HistoryScreen(),
    RouteNames.settingScreen: (context) => const SettingScreen(),
    RouteNames.helpNowScreen: (context) => const HelpNowScreen(),
    RouteNames.myReportsScreen: (context) => const MyReportsScreen(),
    RouteNames.webViewScreen: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      return WebViewScreen(
        url: args['url']!,
        title: args['title'] ?? 'Safe Link',
      );
    },
    RouteNames.historyDetailScreen: (context) {
      final result =
          ModalRoute.of(context)!.settings.arguments as LinkAnalysisResult;
      return HistoryDetailScreen(result: result);
    },
  };
}
