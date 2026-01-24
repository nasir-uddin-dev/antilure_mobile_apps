import 'package:antilure_mobile_apps/features/home_screen/model/qr_scan_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrScanProvider = StateNotifierProvider<QrScanNotifier, QrScanState>(
        (ref) => QrScanNotifier()
);

class QrScanNotifier extends StateNotifier<QrScanState> {
  QrScanNotifier() : super(QrScanState.initial());

  void onQrScanned(String value) {
    if (state.isScanCompleted) return;
    state = state.copyWith(scannedResult: value, isScanCompleted: true);
  }
}
