import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';
import 'package:flutter/material.dart';

class ThreatLevelHelper {
  static Color getThreatColor(ThreatLevel level) {
    switch (level) {
      case ThreatLevel.low:
        return Colors.green;
      case ThreatLevel.medium:
        return Colors.orange;
      case ThreatLevel.high:
        return Colors.red;
    }
  }

  static Color getBackgroundColor(ThreatLevel level) {
    switch (level) {
      case ThreatLevel.low:
        return Color(0xFFE9FAF3);
      case ThreatLevel.medium:
        return Color(0xFFFFF7ED);
      case ThreatLevel.high:
        return Color(0xFFFFEDED);
    }
  }

  static IconData getThreatIcon(ThreatLevel level) {
    switch (level) {
      case ThreatLevel.low:
        return Icons.check_circle;
      case ThreatLevel.medium:
        return Icons.warning;
      case ThreatLevel.high:
        return Icons.dangerous;
    }
  }

  static String getThreatText(ThreatLevel level) {
    switch (level) {
      case ThreatLevel.low:
        return 'Low Risk';
      case ThreatLevel.medium:
        return 'Medium Risk';
      case ThreatLevel.high:
        return 'High Risk';
    }
  }
}
