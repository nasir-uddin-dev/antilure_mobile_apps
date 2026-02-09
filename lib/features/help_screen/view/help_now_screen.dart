import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:antilure_mobile_apps/core/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class HelpNowScreen extends StatelessWidget {
  const HelpNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            title: 'Help Now',
            subTitle: 'Get immediate help if you think you\'re being scammed',
            notificationCount: 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  _buildScenarioCard(
                    context,
                    title: 'Suspicious SMS',
                    subtitle:
                        'Received a text message asking for personal info',
                    icon: Icons.sms_outlined,
                    color: Color(0xFF2FA4E7),
                    backgroundColor: Color(0xFFEAF6FD),
                    scenario: ScenarioType.suspiciousSMS,
                  ),
                  SizedBox(height: 16.h),
                  _buildScenarioCard(
                    context,
                    title: 'Phone Call Scam',
                    subtitle: 'Someone calling claiming to be from a company',
                    icon: Icons.phone_outlined,
                    color: Color(0xFFA855F7),
                    backgroundColor: Color(0xFFFAF5FF),
                    scenario: ScenarioType.phoneCall,
                  ),
                  SizedBox(height: 16.h),
                  _buildScenarioCard(
                    context,
                    title: 'Fake Delivery Message',
                    subtitle: 'Message about a package delivery issue',
                    icon: Icons.local_shipping_outlined,
                    color: Color(0xFFF97316),
                    backgroundColor: Color(0xFFFFF7ED),
                    scenario: ScenarioType.fakeDelivery,
                  ),
                  SizedBox(height: 16.h),
                  _buildScenarioCard(
                    context,
                    title: 'Social Media Scam',
                    subtitle: 'Suspicious messages or friend requests',
                    icon: Ionicons.logo_facebook,
                    color: Color(0xFF10B981),
                    backgroundColor: Color(0xFFE9FAF3),
                    scenario: ScenarioType.socialMedia,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required ScenarioType scenario,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScenarioGuidanceScreen(scenario: scenario),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Icon(icon, size: 28.sp, color: color),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF070707),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14.sp, color: Color(0xFF4A4C56)),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

enum ScenarioType { suspiciousSMS, phoneCall, fakeDelivery, socialMedia }

class ScenarioGuidanceScreen extends StatelessWidget {
  final ScenarioType scenario;

  const ScenarioGuidanceScreen({super.key, required this.scenario});

  @override
  Widget build(BuildContext context) {
    final guidance = _getGuidance();

    return Scaffold(
      appBar: AppBar(
        title: Text(guidance['title']!),
        backgroundColor: Color(0xFF2FA4E7),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Color(0xFFF97316), width: 2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Color(0xFFF97316),
                    size: 32.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Stay calm. Follow these steps.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF97316),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            ...(guidance['steps'] as List<Map<String, String>>)
                .asMap()
                .entries
                .map((entry) {
                  final index = entry.key;
                  final step = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: _buildStepCard(
                      index + 1,
                      step['title']!,
                      step['description']!,
                    ),
                  );
                })
                .toList(),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Color(0xFFE9FAF3),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Remember',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    guidance['remember']!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xFF4A4C56),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.reportScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2FA4E7),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Report This Scam',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(int stepNumber, String title, String description) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: Color(0xFF2FA4E7),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF070707),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF4A4C56),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getGuidance() {
    switch (scenario) {
      case ScenarioType.suspiciousSMS:
        return {
          'title': 'Suspicious SMS',
          'steps': [
            {
              'title': 'Don\'t click any links',
              'description':
                  'Do not tap on any links in the message, even if they look real.',
            },
            {
              'title': 'Don\'t reply',
              'description':
                  'Do not respond to the message. This confirms your number is active.',
            },
            {
              'title': 'Check the sender',
              'description':
                  'Real companies use short codes or official numbers. Random numbers are suspicious.',
            },
            {
              'title': 'Contact the company directly',
              'description':
                  'If the message claims to be from a company, call them using the number on their official website.',
            },
            {
              'title': 'Delete the message',
              'description':
                  'After reporting, delete the message from your phone.',
            },
          ],
          'remember':
              'Real companies will never ask for passwords, PINs, or credit card numbers via text message.',
        };
      case ScenarioType.phoneCall:
        return {
          'title': 'Phone Call Scam',
          'steps': [
            {
              'title': 'Hang up immediately',
              'description':
                  'If something feels wrong, hang up. You can always call back.',
            },
            {
              'title': 'Don\'t give personal information',
              'description':
                  'Never share passwords, card numbers, or account details over the phone.',
            },
            {
              'title': 'Don\'t press any buttons',
              'description':
                  'Scammers may ask you to press numbers. Just hang up instead.',
            },
            {
              'title': 'Verify independently',
              'description':
                  'Look up the company\'s official number online and call them directly.',
            },
            {
              'title': 'Block the number',
              'description':
                  'Block the caller\'s number on your phone to prevent future calls.',
            },
          ],
          'remember':
              'Government agencies and banks will never call asking for immediate payment or threatening arrest.',
        };
      case ScenarioType.fakeDelivery:
        return {
          'title': 'Fake Delivery Message',
          'steps': [
            {
              'title': 'Don\'t click the link',
              'description':
                  'Fake delivery messages contain links to steal your information.',
            },
            {
              'title': 'Check your orders',
              'description':
                  'Go directly to the delivery company\'s app or website to check if you have a real package.',
            },
            {
              'title': 'Look for red flags',
              'description':
                  'Poor grammar, urgent language, or asking for payment are warning signs.',
            },
            {
              'title': 'Verify tracking numbers',
              'description':
                  'If you have a tracking number, enter it on the official website, not through the link.',
            },
            {
              'title': 'Report the message',
              'description':
                  'Forward the message to the delivery company\'s official spam reporting service.',
            },
          ],
          'remember':
              'Real delivery companies will never ask for payment or personal details via text message.',
        };
      case ScenarioType.socialMedia:
        return {
          'title': 'Social Media Scam',
          'steps': [
            {
              'title': 'Don\'t click suspicious links',
              'description':
                  'Even from friends - their account might be hacked.',
            },
            {
              'title': 'Verify the person',
              'description':
                  'If a friend sends an unusual message, call or text them directly to confirm.',
            },
            {
              'title': 'Check the profile',
              'description':
                  'Fake accounts often have few posts, recent creation dates, or stock photos.',
            },
            {
              'title': 'Report and block',
              'description':
                  'Report the account to the social media platform and block them.',
            },
            {
              'title': 'Warn your friends',
              'description':
                  'Let your friends know about the scam so they don\'t fall for it.',
            },
          ],
          'remember':
              'Never send money to someone you\'ve only met online, even if they seem trustworthy.',
        };
    }
  }
}
