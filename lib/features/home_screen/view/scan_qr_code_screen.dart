import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:antilure_mobile_apps/features/home_screen/view_model/qr_scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQrCodeScreen extends ConsumerStatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  ConsumerState<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends ConsumerState<ScanQrCodeScreen> {
  final MobileScannerController _cameraController = MobileScannerController();

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qrState = ref.watch(qrScanProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            /// SCANNER
            Expanded(
              flex: 2,
              child: MobileScanner(
                controller: _cameraController,
                onDetect: (capture) {
                  final value = capture.barcodes.first.rawValue;
                  if (value != null) {
                    ref.read(qrScanProvider.notifier).onQrScanned(value);
                  }
                },
              ),
            ),
            SizedBox(height: 16.h),

            /// RESULT
            Expanded(
              child: Column(
                children: [
                  if (qrState.scannedResult != null) ...[
                    QrImageView(
                      data: qrState.scannedResult!,
                      size: 120.r,
                      version: QrVersions.auto,
                    ),
                    SizedBox(height: 8.h),
                    Text("Scanned Result", style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: 4.h),
                    Text(
                      qrState.scannedResult!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    customButton(
                      text: "Copy",
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: qrState.scannedResult!),
                        );
                      },
                    ),
                  ] else
                    Text(
                      "Scan a QR code",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
