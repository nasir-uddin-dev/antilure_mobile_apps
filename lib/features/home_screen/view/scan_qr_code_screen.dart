import 'package:antilure_mobile_apps/core/common_widgets/button_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';
import 'package:antilure_mobile_apps/core/utils/threat_level_helper.dart';
import 'package:antilure_mobile_apps/features/home_screen/view_model/qr_scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      appBar: AppBar(
        title: Text('Scan QR Code'),
        actions: [
          if (qrState.scannedResult != null)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                ref.read(qrScanProvider.notifier).reset();
              },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            ///----------------- SCANNER ---------------------------------------
            if (!qrState.isScanCompleted)
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
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
              ),

            if (qrState.isScanCompleted) ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// QR Code Display
                      Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: QrImageView(
                          data: qrState.scannedResult!,
                          size: 150.r,
                          version: QrVersions.auto,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// Scanned Text
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scanned Content:",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              qrState.scannedResult!,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            SizedBox(height: 12.h),
                            customButton(
                              text: "Copy",
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: qrState.scannedResult!),
                                );
                                Fluttertoast.showToast(
                                  msg: 'Copied to clipboard',
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
                      ),
                      SizedBox(height: 16.h),

                      /// Analysis Result
                      if (qrState.isAnalyzing)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16.h),
                              Text(
                                'Analyzing URL...',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (qrState.analysisResult != null) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24.r),
                          decoration: BoxDecoration(
                            color: ThreatLevelHelper.getBackgroundColor(
                              qrState.analysisResult!.threatLevel,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: ThreatLevelHelper.getThreatColor(
                                qrState.analysisResult!.threatLevel,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48.r,
                                    height: 48.r,
                                    decoration: BoxDecoration(
                                      color: ThreatLevelHelper.getThreatColor(
                                        qrState.analysisResult!.threatLevel,
                                      ).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                    ),
                                    child: Icon(
                                      ThreatLevelHelper.getThreatIcon(
                                        qrState.analysisResult!.threatLevel,
                                      ),
                                      color: ThreatLevelHelper.getThreatColor(
                                        qrState.analysisResult!.threatLevel,
                                      ),
                                      size: 28.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          qrState.analysisResult!.message,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                ThreatLevelHelper.getThreatColor(
                                                  qrState
                                                      .analysisResult!
                                                      .threatLevel,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'Risk Score: ${qrState.analysisResult!.riskScore.toStringAsFixed(0)}%',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                qrState.analysisResult!.description,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              if (qrState
                                  .analysisResult!
                                  .detectedThreats
                                  .isNotEmpty) ...[
                                SizedBox(height: 16.h),
                                Text(
                                  'Detected Issues:',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                ...qrState.analysisResult!.detectedThreats.map(
                                  (threat) => Padding(
                                    padding: EdgeInsets.only(bottom: 4.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.warning_amber,
                                          size: 16.sp,
                                          color: Colors.orange,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Text(
                                            threat,
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              if (qrState.analysisResult!.threatLevel ==
                                  ThreatLevel.low)
                                SizedBox(height: 16.h),
                              if (qrState.analysisResult!.threatLevel ==
                                  ThreatLevel.low)
                                customButton(
                                  text: "Open Link in Safe Browser",
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.webViewScreen,
                                      arguments: {
                                        'url': qrState.scannedResult!,
                                        'title': 'Safe QR Link',
                                      },
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ] else ...[
              SizedBox(height: 16.h),
              Text(
                "Position QR code within frame",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "The QR code will be scanned automatically",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
