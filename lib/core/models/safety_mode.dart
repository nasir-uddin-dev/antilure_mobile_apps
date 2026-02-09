enum SafetyMode {
  standard,
  senior,
  childLight,
}

class SafetyModeConfig {
  final SafetyMode mode;
  final double textScaleFactor;
  final String description;

  SafetyModeConfig({
    required this.mode,
    required this.textScaleFactor,
    required this.description,
  });

  static SafetyModeConfig fromMode(SafetyMode mode) {
    switch (mode) {
      case SafetyMode.standard:
        return SafetyModeConfig(
          mode: SafetyMode.standard,
          textScaleFactor: 1.0,
          description: 'Standard mode with normal text size',
        );
      case SafetyMode.senior:
        return SafetyModeConfig(
          mode: SafetyMode.senior,
          textScaleFactor: 1.3,
          description: 'Larger text and simpler wording',
        );
      case SafetyMode.childLight:
        return SafetyModeConfig(
          mode: SafetyMode.childLight,
          textScaleFactor: 1.1,
          description: 'Extra warnings for young users',
        );
    }
  }

  String getSimplifiedText(String standard, String senior, String child) {
    switch (mode) {
      case SafetyMode.standard:
        return standard;
      case SafetyMode.senior:
        return senior;
      case SafetyMode.childLight:
        return child;
    }
  }
}
