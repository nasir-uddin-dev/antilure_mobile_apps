# Malicious Link Detection System

## Overview
This AntiLure mobile app includes a comprehensive local malicious link detection system that analyzes URLs and QR codes for potential security threats **without requiring a backend server**. All analysis is performed on-device using advanced algorithms implemented in Dart.

## Features

### 1. **QR Code Scanning with Security Analysis**
- Scan QR codes using your device camera
- Automatic URL extraction and security analysis
- Real-time threat detection
- Visual indicators for threat levels

### 2. **Manual Link Checking**
- Paste any URL for instant security analysis
- Detailed threat reports
- Risk score calculation (0-100%)
- Actionable security recommendations

### 3. **Scan History**
- Persistent storage of all scanned links using local storage
- View past scan results
- Track threat patterns over time
- No data sent to external servers

### 4. **Local Storage**
- All data stored locally using SharedPreferences
- Whitelist and blacklist management
- Scan history (last 50 scans)
- Complete offline functionality

## Threat Detection Algorithms

### 1. **Suspicious TLD (Top Level Domain) Detection**
Checks for domains using free or commonly abused top-level domains:
- `.tk`, `.ml`, `.ga`, `.cf`, `.gq`
- `.xyz`, `.top`, `.work`, `.click`
- `.link`, `.download`, `.date`
- And many more suspicious TLDs

### 2. **Malicious Keyword Detection**
Scans URLs for common phishing keywords:
- `verify-account`, `confirm-identity`
- `suspended-account`, `urgent-action`
- `claim-prize`, `reset-password`
- `update-payment`, `account-locked`
- `free-money`, `winner`, `lottery`
- And more phishing indicators

### 3. **Phishing Brand Impersonation**
Detects URLs attempting to impersonate legitimate brands:
- PayPal, Amazon, Apple, Microsoft
- Google, Facebook, Netflix
- Banking institutions
- Government services (IRS, USPS)
- Shipping companies (DHL, FedEx, UPS)

### 4. **URL Shortener Detection**
Identifies shortened URLs that hide the true destination:
- bit.ly, tinyurl.com, goo.gl
- t.co, ow.ly, is.gd
- And other URL shortening services

### 5. **IP Address Usage**
Flags URLs using direct IP addresses instead of domain names:
- IPv4 pattern detection
- Unusual for legitimate websites

### 6. **Excessive Subdomain Analysis**
Detects URLs with unusually deep subdomain structures:
- More than 2 subdomain levels
- Common tactic to mimic legitimate domains

### 7. **Suspicious Port Detection**
Identifies non-standard ports that may indicate malicious activity:
- Ports other than 80, 443, or 8080
- Often used in phishing and malware distribution

### 8. **Homograph Attack Detection**
Detects internationalized domain names (IDN) used for spoofing:
- Mixed scripts (Cyrillic, Greek)
- Lookalike characters
- Unicode homograph attacks

### 9. **URL Length Analysis**
Flags unusually long URLs:
- URLs over 200 characters
- Often used to obfuscate malicious content

### 10. **Special Character Analysis**
Detects suspicious character patterns:
- Multiple `@` symbols
- Unusual slash patterns
- URL obfuscation techniques

### 11. **HTTPS Verification**
Checks for secure HTTPS connections:
- Flags non-HTTPS URLs
- Important for secure data transmission

## Threat Levels

### 🟢 Safe (Risk Score: 0-24%)
- **Color**: Green
- **Icon**: Check Circle
- **Action**: URL appears safe to visit
- **Description**: No significant threats detected

### 🟡 Suspicious (Risk Score: 25-49%)
- **Color**: Orange
- **Icon**: Warning
- **Action**: Exercise caution
- **Description**: Some concerning patterns detected

### 🟠 Dangerous (Risk Score: 50-74%)
- **Color**: Deep Orange
- **Icon**: Dangerous
- **Action**: Not recommended to visit
- **Description**: Multiple red flags associated with phishing

### 🔴 High Risk (Risk Score: 75-100%)
- **Color**: Red
- **Icon**: Block
- **Action**: DO NOT VISIT
- **Description**: Extremely dangerous, likely malicious

## Risk Score Calculation

The risk score is calculated based on weighted threat detection:

| Threat Type | Weight |
|------------|--------|
| Blacklisted URL | +100 |
| Phishing Pattern | +25 |
| Malicious Keyword | +25 |
| URL Shortener | +20 |
| IP Address | +20 |
| No HTTPS | +15 |
| Homograph Attack | +30 |
| Other Issues | +10 each |

Maximum score is capped at 100%.

## Data Storage

### Local Storage Keys:
- `scan_history`: Last 50 scan results
- `blacklist_urls`: User-defined blacklisted URLs
- `whitelist_urls`: User-defined whitelisted URLs

### Data Persistence:
- All data stored using `shared_preferences` package
- No external API calls
- Complete offline functionality
- Data remains on device only

## Usage Examples

### Scanning a QR Code:
1. Open app and tap "Scan QR Code"
2. Point camera at QR code
3. Automatic detection and analysis
4. View threat report with detailed findings
5. Copy or open safe links

### Checking a Link Manually:
1. Open app and tap "Check a Link"
2. Paste URL into text field
3. Tap "Check Link" button
4. View comprehensive security analysis
5. See detected threats and risk score

### Viewing History:
1. Navigate to History screen
2. View all past scans
3. See threat levels and timestamps
4. Review detected issues

## Technical Implementation

### Core Service: `AdvancedLinkChecker`
Located at: `lib/core/services/advanced_link_checker.dart`

**Key Methods:**
- `analyzeUrl(String url)`: Main analysis function
- `getHistory()`: Retrieve scan history
- `addToBlacklist(String url)`: Add URL to blacklist
- `addToWhitelist(String url)`: Add URL to whitelist

### State Management: Riverpod
- `linkCheckerProvider`: Manages link checking state
- `qrScanProvider`: Manages QR scanning state
- `historyProvider`: Provides scan history

### UI Components:
- **ScanQrCodeScreen**: QR code scanning with camera
- **CheckLinkScreen**: Manual URL input and checking
- **HistoryScreen**: View past scan results

## Algorithms Used

### 1. Pattern Matching
- Regular expressions for URL component extraction
- Keyword matching for phishing detection
- Character pattern analysis

### 2. Heuristic Analysis
- Domain structure analysis
- TLD reputation checking
- Brand name comparison

### 3. Risk Scoring
- Weighted threat accumulation
- Multi-factor security assessment
- Normalized risk percentage

### 4. Local Database
- Predefined malicious keyword lists
- Known suspicious TLDs
- Trusted brand domains
- Common URL shorteners

## Security Features

### Privacy-First Design:
- ✅ No data sent to external servers
- ✅ All processing done locally
- ✅ No user tracking
- ✅ Complete offline functionality
- ✅ Data stays on device

### Protection Against:
- ✅ Phishing attacks
- ✅ Malware distribution
- ✅ Social engineering
- ✅ Brand impersonation
- ✅ URL obfuscation
- ✅ Homograph attacks

## Future Enhancements

Potential improvements:
1. Machine learning model for pattern recognition
2. Expanded malicious keyword database
3. Real-time threat intelligence updates (optional)
4. Advanced homograph detection
5. Domain reputation scoring
6. SSL certificate validation
7. Behavioral analysis patterns

## Best Practices

### For Users:
1. Always scan unknown QR codes before visiting
2. Verify sender before clicking links
3. Check the full URL, not just the displayed text
4. Be cautious of urgent or threatening language
5. Look for HTTPS and proper spelling
6. Never enter personal info on suspicious sites

### For Developers:
1. Regular updates to malicious keyword lists
2. Expand TLD monitoring
3. Test with known phishing examples
4. Keep algorithm weights balanced
5. Monitor false positive rates
6. User feedback integration

## Dependencies

Required packages:
```yaml
shared_preferences: ^2.2.1  # Local data storage
mobile_scanner: ^7.1.4       # QR code scanning
qr_flutter: ^4.0.0           # QR code display
url_launcher: ^6.1.14        # Open safe URLs
flutter_riverpod: ^2.6.1     # State management
intl: ^0.19.0                # Date formatting
```

## Performance

- **Analysis Time**: < 100ms per URL
- **Storage**: Minimal (< 1MB for 50 scans)
- **Battery Impact**: Low
- **Memory Usage**: Efficient
- **Offline Mode**: Fully functional

## Disclaimer

This system provides an additional layer of security but should not be considered foolproof. Always exercise caution when:
- Clicking unknown links
- Scanning QR codes from untrusted sources
- Entering personal or financial information
- Responding to unsolicited messages

For maximum security, combine this app with:
- Updated antivirus software
- Secure browsers
- Common sense
- Verification of sender identity

## License

This malicious link detection system is part of the AntiLure Mobile Apps project.

## Support

For issues, questions, or contributions, please contact the development team.

---

**Stay Safe Online! 🛡️**
