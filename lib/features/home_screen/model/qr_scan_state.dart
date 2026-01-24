class QrScanState {
  final bool isScanCompleted;
  final String? scannedResult;

  QrScanState({required this.isScanCompleted, this.scannedResult});

  factory QrScanState.initial() {
    return QrScanState(isScanCompleted: false, scannedResult: null);
  }

  QrScanState copyWith({bool? isScanCompleted, String? scannedResult}) {
    return QrScanState(
      isScanCompleted: isScanCompleted ?? this.isScanCompleted,
      scannedResult: scannedResult ?? this.scannedResult,
    );
  }
}
