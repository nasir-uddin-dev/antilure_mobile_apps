import 'dart:convert';
import 'package:antilure_mobile_apps/core/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

enum ThreatLevel {
  low, // Risk Score: 0-33%
  medium, // Risk Score: 34-66%
  high, // Risk Score: 67-100%
}

class LinkAnalysisResult {
  final String url;
  final ThreatLevel threatLevel;
  final String message;
  final String description;
  final List<String> detectedThreats;
  final double riskScore; // 0-100
  final DateTime scanTime;

  LinkAnalysisResult({
    required this.url,
    required this.threatLevel,
    required this.message,
    required this.description,
    required this.detectedThreats,
    required this.riskScore,
    required this.scanTime,
  });

  Map<String, dynamic> toJson() => {
    'url': url,
    'threatLevel': threatLevel.toString(),
    'message': message,
    'description': description,
    'detectedThreats': detectedThreats,
    'riskScore': riskScore,
    'scanTime': scanTime.toIso8601String(),
  };

  factory LinkAnalysisResult.fromJson(Map<String, dynamic> json) {
    return LinkAnalysisResult(
      url: json['url'],
      threatLevel: ThreatLevel.values.firstWhere(
        (e) => e.toString() == json['threatLevel'],
      ),
      message: json['message'],
      description: json['description'],
      detectedThreats: List<String>.from(json['detectedThreats']),
      riskScore: json['riskScore'],
      scanTime: DateTime.parse(json['scanTime']),
    );
  }

  String getRiskLevelText() {
    switch (threatLevel) {
      case ThreatLevel.low:
        return 'Low Risk';
      case ThreatLevel.medium:
        return 'Medium Risk';
      case ThreatLevel.high:
        return 'High Risk';
    }
  }
}

class AdvancedLinkChecker {
  // Known malicious patterns and keywords
  static final List<String> _maliciousKeywords = [
    // Account & Security
    'verify-account',
    'confirm-identity',
    'account-suspended',
    'suspended-account',
    'account-locked',
    'unusual-activity',
    'security-alert',
    'secure-login',
    'validate-info',
    'authentication-required',
    'two-factor',
    '2fa',
    'login-attempt',
    'password-expired',
    'reset-password',
    'update-password',

    // Urgency & Pressure
    'urgent-action',
    'act-now',
    'immediate-action',
    'limited-offer',
    'expires-today',
    'final-notice',
    'last-warning',
    'time-sensitive',
    'click-here-now',

    // Payment & Banking
    'update-payment',
    'billing-issue',
    'payment-failed',
    'verify-payment',
    'bank-alert',
    'credit-card',
    'debit-card',
    'refund-pending',
    'transaction-failed',

    // Rewards & Too-Good-To-Be-True
    'free-money',
    'claim-prize',
    'cash-reward',
    'bonus-credited',
    'reward-awaiting',
    'gift-card',
    'voucher',
    'congratulations',
    'winner',
    'lottery',
    'inheritance',

    // Impersonation & Brands
    'support-team',
    'customer-support',
    'help-center',
    'official-notice',
    'admin',
    'service-desk',

    // Crypto & Investment Scams
    'crypto-wallet',
    'wallet-connect',
    'airdrop',
    'token-claim',
    'double-your-money',
    'investment-opportunity',
    'guaranteed-profit',

    // Suspicious Actions
    'download-now',
    'install-update',
    'open-attachment',
    'verify-now',
    'confirm-now',
  ];

  // Suspicious TLDs (Top Level Domains)
  static final List<String> _suspiciousTlds = [
    '.tk',
    '.ml',
    '.ga',
    '.cf',
    '.gq',
    '.xyz',
    '.top',
    '.work',
    '.click',
    '.link',
    '.download',
    '.date',
    '.racing',
    '.webcam',
    '.loan',
    '.win',
    '.bid',
    '.faith',
    '.science',
  ];

  // Common phishing brand names
  static final List<String> _phishingBrands = [
    'paypal',
    'amazon',
    'apple',
    'microsoft',
    'google',
    'facebook',
    'netflix',
    'instagram',
    'whatsapp',
    'dhl',
    'fedex',
    'ups',
    'bank',
    'irs',
    'usps',
  ];

  // URL shortener services
  static final List<String> _urlShorteners = [
    'bit.ly',
    'tinyurl.com',
    'goo.gl',
    't.co',
    'ow.ly',
    'is.gd',
    'buff.ly',
    'adf.ly',
    'bc.vc',
    'shorte.st',
  ];

  // Safe domains (whitelist)
  static final List<String> _safeDomains = [
    'google.com',
    'youtube.com',
    'facebook.com',
    'twitter.com',
    'instagram.com',
    'linkedin.com',
    'github.com',
    'stackoverflow.com',
    'wikipedia.org',
    'amazon.com',
    'apple.com',
    'microsoft.com',
  ];

  /// Main analysis function
  Future<LinkAnalysisResult> analyzeUrl(String url) async {
    try {
      // Normalize URL
      url = _normalizeUrl(url);

      // Parse URL components
      Uri uri = Uri.parse(url);

      // Initialize threat detection
      List<String> threats = [];
      double riskScore = 0.0;

      // Check whitelist/blacklist
      if (await _isWhitelisted(url)) {
        return _createSafeResult(url);
      }

      if (await _isBlacklisted(url)) {
        return _createDangerousResult(
          url,
          'Blocked Domain',
          'This URL is in the blacklist database.',
          ['Blacklisted URL'],
          100.0,
        );
      }

      // Run all detection algorithms
      threats.addAll(await _checkSuspiciousTld(uri));
      threats.addAll(await _checkMaliciousKeywords(url));
      threats.addAll(await _checkPhishingPatterns(uri));
      threats.addAll(await _checkUrlShortener(uri));
      threats.addAll(await _checkIPAddress(uri));
      threats.addAll(await _checkExcessiveSubdomains(uri));
      threats.addAll(await _checkSuspiciousPort(uri));
      threats.addAll(await _checkHomographAttack(uri));
      threats.addAll(await _checkUrlLength(url));
      threats.addAll(await _checkSpecialCharacters(url));
      threats.addAll(await _checkHttps(uri));

      // Calculate risk score
      riskScore = _calculateRiskScore(threats);

      // Determine threat level
      ThreatLevel threatLevel = _determineThreatLevel(riskScore);

      // Generate result
      LinkAnalysisResult result = _generateResult(
        url,
        threatLevel,
        threats,
        riskScore,
      );

      // Save to history
      await _saveToHistory(result);

      return result;
    } catch (e) {
      return LinkAnalysisResult(
        url: url,
        threatLevel: ThreatLevel.medium,
        message: 'Analysis Error',
        description: 'Unable to analyze this URL properly: ${e.toString()}',
        detectedThreats: ['Invalid URL format'],
        riskScore: 50.0,
        scanTime: DateTime.now(),
      );
    }
  }

  /// Normalize URL
  String _normalizeUrl(String url) {
    url = url.trim().toLowerCase();
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    return url;
  }

  /// Check suspicious TLD
  Future<List<String>> _checkSuspiciousTld(Uri uri) async {
    List<String> threats = [];
    String host = uri.host.toLowerCase();

    for (String tld in _suspiciousTlds) {
      if (host.endsWith(tld)) {
        threats.add('Suspicious domain extension: $tld');
      }
    }

    return threats;
  }

  /// Check malicious keywords
  Future<List<String>> _checkMaliciousKeywords(String url) async {
    List<String> threats = [];
    String lowerUrl = url.toLowerCase();

    for (String keyword in _maliciousKeywords) {
      if (lowerUrl.contains(keyword)) {
        threats.add('Suspicious keyword detected: $keyword');
      }
    }

    return threats;
  }

  /// Check phishing patterns
  Future<List<String>> _checkPhishingPatterns(Uri uri) async {
    List<String> threats = [];
    String host = uri.host.toLowerCase();

    for (String brand in _phishingBrands) {
      if (host.contains(brand) && !_isTrustedBrandDomain(host, brand)) {
        threats.add('Possible phishing attempt mimicking: $brand');
      }
    }

    return threats;
  }

  /// Check if it's a trusted brand domain
  bool _isTrustedBrandDomain(String host, String brand) {
    // Simple check - in real app, maintain a database of legitimate domains
    Map<String, List<String>> trustedDomains = {
      'paypal': ['paypal.com'],
      'amazon': ['amazon.com', 'amazon.co.uk', 'amazon.de'],
      'apple': ['apple.com', 'icloud.com'],
      'microsoft': ['microsoft.com', 'outlook.com', 'live.com'],
      'google': ['google.com', 'gmail.com', 'youtube.com'],
    };

    if (trustedDomains.containsKey(brand)) {
      for (String trusted in trustedDomains[brand]!) {
        if (host == trusted || host.endsWith('.$trusted')) {
          return true;
        }
      }
    }

    return false;
  }

  /// Check URL shortener
  Future<List<String>> _checkUrlShortener(Uri uri) async {
    List<String> threats = [];
    String host = uri.host.toLowerCase();

    for (String shortener in _urlShorteners) {
      if (host.contains(shortener)) {
        threats.add('URL shortener detected - destination unknown');
      }
    }

    return threats;
  }

  /// Check if IP address is used instead of domain
  Future<List<String>> _checkIPAddress(Uri uri) async {
    List<String> threats = [];
    String host = uri.host;

    // Check for IPv4
    RegExp ipv4Pattern = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$');
    if (ipv4Pattern.hasMatch(host)) {
      threats.add('Direct IP address used instead of domain name');
    }

    return threats;
  }

  /// Check excessive subdomains
  Future<List<String>> _checkExcessiveSubdomains(Uri uri) async {
    List<String> threats = [];
    String host = uri.host;

    int subdomainCount = host.split('.').length - 2;
    if (subdomainCount > 2) {
      threats.add('Excessive subdomains detected ($subdomainCount levels)');
    }

    return threats;
  }

  /// Check suspicious port
  Future<List<String>> _checkSuspiciousPort(Uri uri) async {
    List<String> threats = [];

    if (uri.hasPort) {
      int port = uri.port;
      if (port != 80 && port != 443 && port != 8080) {
        threats.add('Unusual port number: $port');
      }
    }

    return threats;
  }

  /// Check homograph attack (IDN homograph attack)
  Future<List<String>> _checkHomographAttack(Uri uri) async {
    List<String> threats = [];
    String host = uri.host;

    // Check for mixed scripts or suspicious unicode characters
    if (_containsSuspiciousCharacters(host)) {
      threats.add('Possible homograph attack detected');
    }

    return threats;
  }

  bool _containsSuspiciousCharacters(String text) {
    // Check for non-ASCII characters that might be used for spoofing
    for (int i = 0; i < text.length; i++) {
      int code = text.codeUnitAt(i);
      // Check for Cyrillic, Greek, or other lookalike characters
      if ((code >= 0x0400 && code <= 0x04FF) || // Cyrillic
          (code >= 0x0370 && code <= 0x03FF)) {
        // Greek
        return true;
      }
    }
    return false;
  }

  /// Check URL length
  Future<List<String>> _checkUrlLength(String url) async {
    List<String> threats = [];

    if (url.length > 200) {
      threats.add('Unusually long URL (${url.length} characters)');
    }

    return threats;
  }

  /// Check special characters
  Future<List<String>> _checkSpecialCharacters(String url) async {
    List<String> threats = [];

    int atCount = '@'.allMatches(url).length;
    if (atCount > 0) {
      threats.add('Contains @ symbol - possible URL obfuscation');
    }

    if (url.contains('//') && url.indexOf('//') != url.indexOf('://')) {
      threats.add('Multiple slashes detected');
    }

    return threats;
  }

  /// Check HTTPS
  Future<List<String>> _checkHttps(Uri uri) async {
    List<String> threats = [];

    if (uri.scheme != 'https') {
      threats.add('Not using secure HTTPS connection');
    }

    return threats;
  }

  /// Calculate risk score
  double _calculateRiskScore(List<String> threats) {
    if (threats.isEmpty) return 0.0;

    // Weight different threats
    double score = 0.0;

    for (String threat in threats) {
      if (threat.contains('Blacklisted')) {
        score += 100;
      } else if (threat.contains('phishing') ||
          threat.contains('Suspicious keyword')) {
        score += 25;
      } else if (threat.contains('URL shortener') ||
          threat.contains('IP address')) {
        score += 20;
      } else if (threat.contains('Not using secure HTTPS')) {
        score += 15;
      } else if (threat.contains('homograph')) {
        score += 30;
      } else {
        score += 10;
      }
    }

    return score > 100 ? 100 : score;
  }

  /// Determine threat level
  ThreatLevel _determineThreatLevel(double riskScore) {
    if (riskScore >= 67) {
      return ThreatLevel.high;
    } else if (riskScore >= 34) {
      return ThreatLevel.medium;
    } else {
      return ThreatLevel.low;
    }
  }

  /// Generate result
  LinkAnalysisResult _generateResult(
    String url,
    ThreatLevel threatLevel,
    List<String> threats,
    double riskScore,
  ) {
    String message;
    String description;

    switch (threatLevel) {
      case ThreatLevel.low:
        message = 'This link looks safe';
        description =
            'We analyzed this URL and didn\'t find any significant threats. However, always exercise caution when sharing personal information.';
        break;
      case ThreatLevel.medium:
        message = 'Be careful with this link';
        description =
            'We detected some concerning patterns in this URL. Double-check the sender before clicking.';
        break;
      case ThreatLevel.high:
        message = 'Do not open this link';
        description =
            'This URL shows multiple red flags associated with phishing or malware. We strongly recommend NOT visiting this link.';
        break;
    }

    return LinkAnalysisResult(
      url: url,
      threatLevel: threatLevel,
      message: message,
      description: description,
      detectedThreats: threats,
      riskScore: riskScore,
      scanTime: DateTime.now(),
    );
  }

  /// Create safe result
  LinkAnalysisResult _createSafeResult(String url) {
    return LinkAnalysisResult(
      url: url,
      threatLevel: ThreatLevel.low,
      message: 'This link looks safe',
      description:
          'This URL is whitelisted and considered safe. We scanned it and didn\'t find any known threats.',
      detectedThreats: [],
      riskScore: 0.0,
      scanTime: DateTime.now(),
    );
  }

  /// Create dangerous result
  LinkAnalysisResult _createDangerousResult(
    String url,
    String message,
    String description,
    List<String> threats,
    double riskScore,
  ) {
    return LinkAnalysisResult(
      url: url,
      threatLevel: ThreatLevel.high,
      message: message,
      description: description,
      detectedThreats: threats,
      riskScore: riskScore,
      scanTime: DateTime.now(),
    );
  }

  /// Save to history
  Future<void> _saveToHistory(LinkAnalysisResult result) async {
    try {
      final db = await DatabaseHelper.instance.database;

      // Count existing records
      final countResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM scan_history',
      );
      final count = (countResult.first['count'] as int?) ?? 0;

      // Delete oldest records if we exceed 50
      if (count >= 50) {
        final idsToDelete = await db.rawQuery(
          'SELECT id FROM scan_history ORDER BY scan_time ASC LIMIT ?',
          [count - 49],
        );
        for (var row in idsToDelete) {
          await db.delete(
            'scan_history',
            where: 'id = ?',
            whereArgs: [row['id']],
          );
        }
      }

      // Insert new record
      await db.insert('scan_history', {
        'url': result.url,
        'threat_level': result.threatLevel.toString(),
        'risk_score': result.riskScore,
        'detected_threats': jsonEncode(result.detectedThreats),
        'is_safe': result.threatLevel == ThreatLevel.low ? 1 : 0,
        'scan_time': result.scanTime.millisecondsSinceEpoch,
        'full_data': jsonEncode(result.toJson()),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Get scan history
  Future<List<LinkAnalysisResult>> getHistory() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final rows = await db.query('scan_history', orderBy: 'scan_time DESC');

      return rows.map((row) {
        return LinkAnalysisResult.fromJson(
          jsonDecode(row['full_data'] as String),
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// Clear history
  Future<void> clearHistory() async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('scan_history');
    } catch (e) {
      // Handle error silently
    }
  }

  /// Add to blacklist
  Future<void> addToBlacklist(String url) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert('blacklist', {
        'url': url,
        'added_time': DateTime.now().millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Add to whitelist
  Future<void> addToWhitelist(String url) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert('whitelist', {
        'url': url,
        'added_time': DateTime.now().millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Check if blacklisted
  Future<bool> _isBlacklisted(String url) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'blacklist',
        where: 'url = ?',
        whereArgs: [url],
        limit: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Check if whitelisted
  Future<bool> _isWhitelisted(String url) async {
    try {
      final db = await DatabaseHelper.instance.database;

      // Check whitelist table
      final result = await db.query(
        'whitelist',
        where: 'url = ?',
        whereArgs: [url],
        limit: 1,
      );
      if (result.isNotEmpty) return true;

      // Also check against predefined safe domains
      Uri uri = Uri.parse(url);
      for (String safeDomain in _safeDomains) {
        if (uri.host == safeDomain || uri.host.endsWith('.$safeDomain')) {
          return true;
        }
      }

      return false;
    } catch (e) {
      // Fall back to safe domain check
      Uri uri = Uri.parse(url);
      for (String safeDomain in _safeDomains) {
        if (uri.host == safeDomain || uri.host.endsWith('.$safeDomain')) {
          return true;
        }
      }
      return false;
    }
  }

  /// Remove from blacklist
  Future<void> removeFromBlacklist(String url) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('blacklist', where: 'url = ?', whereArgs: [url]);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Remove from whitelist
  Future<void> removeFromWhitelist(String url) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('whitelist', where: 'url = ?', whereArgs: [url]);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Get blacklist
  Future<List<String>> getBlacklist() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final rows = await db.query('blacklist');
      return rows.map((row) => row['url'] as String).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get whitelist
  Future<List<String>> getWhitelist() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final rows = await db.query('whitelist');
      return rows.map((row) => row['url'] as String).toList();
    } catch (e) {
      return [];
    }
  }

  /// Delete from history
  Future<void> deleteFromHistory(String url) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('scan_history', where: 'url = ?', whereArgs: [url]);
    } catch (e) {
      // Handle error silently
    }
  }
}
