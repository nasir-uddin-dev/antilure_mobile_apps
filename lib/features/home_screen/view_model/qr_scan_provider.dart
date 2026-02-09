import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';
import 'package:antilure_mobile_apps/features/home_screen/model/qr_scan_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrScanProvider = StateNotifierProvider<QrScanNotifier, QrScanState>(
  (ref) => QrScanNotifier(),
);

class QrScanNotifier extends StateNotifier<QrScanState> {
  final AdvancedLinkChecker _linkChecker = AdvancedLinkChecker();

  QrScanNotifier() : super(QrScanState.initial());

  Future<void> onQrScanned(String value) async {
    if (state.isScanCompleted) return;

    state = state.copyWith(
      scannedResult: value,
      isScanCompleted: true,
      isAnalyzing: true,
    );

    // Check if the scanned value is a URL
    if (_isUrl(value)) {
      try {
        final result = await _linkChecker.analyzeUrl(value);
        state = state.copyWith(
          isAnalyzing: false,
          analysisResult: result,
        );
      } catch (e) {
        state = state.copyWith(isAnalyzing: false);
      }
    } else {
      state = state.copyWith(isAnalyzing: false);
    }
  }

  bool _isUrl(String text) {
    return text.startsWith('http://') ||
        text.startsWith('https://') ||
        text.contains('www.') ||
        text.contains('.com') ||
        text.contains('.org') ||
        text.contains('.net');
  }

  void reset() {
    state = QrScanState.initial();
  }
}
