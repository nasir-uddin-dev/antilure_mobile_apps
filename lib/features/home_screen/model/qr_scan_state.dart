import 'package:antilure_mobile_apps/core/services/advanced_link_checker.dart';

class QrScanState {
  final bool isScanCompleted;
  final String? scannedResult;
  final bool isAnalyzing;
  final LinkAnalysisResult? analysisResult;

  QrScanState({
    required this.isScanCompleted,
    this.scannedResult,
    this.isAnalyzing = false,
    this.analysisResult,
  });

  factory QrScanState.initial() {
    return QrScanState(
      isScanCompleted: false,
      scannedResult: null,
      isAnalyzing: false,
      analysisResult: null,
    );
  }

  QrScanState copyWith({
    bool? isScanCompleted,
    String? scannedResult,
    bool? isAnalyzing,
    LinkAnalysisResult? analysisResult,
  }) {
    return QrScanState(
      isScanCompleted: isScanCompleted ?? this.isScanCompleted,
      scannedResult: scannedResult ?? this.scannedResult,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      analysisResult: analysisResult ?? this.analysisResult,
    );
  }
}
