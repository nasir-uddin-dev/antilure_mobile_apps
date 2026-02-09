import 'package:antilure_mobile_apps/core/common_widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({super.key, required this.url, this.title = 'Safe Link'});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String _currentUrl = '';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.url;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _currentUrl = url;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            Fluttertoast.showToast(
              msg: 'Error loading page: ${error.description}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            title: widget.title,
            subTitle: 'Verified Safe Link',
            notificationCount: 1,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  _controller.reload();
                },
              ),
            ],
          ),

          // URL bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border(bottom: BorderSide(color: Colors.green.shade200)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    _currentUrl,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.lock, color: Colors.green, size: 16.sp),
              ],
            ),
          ),

          // Progress indicator
          if (_isLoading)
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),

          // WebView
          Expanded(child: WebViewWidget(controller: _controller)),

          // Bottom navigation buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () async {
                      if (await _controller.canGoBack()) {
                        _controller.goBack();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () async {
                      if (await _controller.canGoForward()) {
                        _controller.goForward();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      _controller.reload();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
