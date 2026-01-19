import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/features/home_screen/view/check_link_screen.dart';
import 'package:antilure_mobile_apps/features/home_screen/view/scan_qr_code_screen.dart';
import 'package:antilure_mobile_apps/features/parent_screen/parent_screen.dart';
import 'package:antilure_mobile_apps/features/report_screen/view/report_screen.dart';
import 'package:antilure_mobile_apps/features/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes{
  static const String initialRoute = '/';

  static final Map<String,WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.parentScreen:(context) => const ParentScreen(),
    RouteNames.checkLinkScreen:(context) => const CheckLinkScreen(),
    RouteNames.scanQrCodeScreen:(context) => const ScanQrCodeScreen(),
    RouteNames.reportScreen:(context) => const ReportScreen()
  };
}