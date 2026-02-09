enum ScamCategory {
  suspiciousSMS,
  phoneCall,
  fakeDelivery,
  socialMedia,
  email,
  other,
}

class ScamReport {
  final String id;
  final ScamCategory category;
  final String description;
  final String? linkOrPhone;
  final DateTime dateTime;

  ScamReport({
    required this.id,
    required this.category,
    required this.description,
    this.linkOrPhone,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category.index,
        'description': description,
        'linkOrPhone': linkOrPhone,
        'dateTime': dateTime.toIso8601String(),
      };

  factory ScamReport.fromJson(Map<String, dynamic> json) {
    return ScamReport(
      id: json['id'],
      category: ScamCategory.values[json['category']],
      description: json['description'],
      linkOrPhone: json['linkOrPhone'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  String getCategoryName() {
    switch (category) {
      case ScamCategory.suspiciousSMS:
        return 'Suspicious SMS';
      case ScamCategory.phoneCall:
        return 'Phone Call Scam';
      case ScamCategory.fakeDelivery:
        return 'Fake Delivery';
      case ScamCategory.socialMedia:
        return 'Social Media Scam';
      case ScamCategory.email:
        return 'Email Scam';
      case ScamCategory.other:
        return 'Other';
    }
  }
}
