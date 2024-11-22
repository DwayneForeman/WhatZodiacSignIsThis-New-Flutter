import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  int _loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the WebView
    _initializeWebView();
  }

  // Initialize WebView and set the NavigationDelegate
  void _initializeWebView() {
    _controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _loadingPercentage = 0; // Reset loading progress
            });
          },
          onProgress: (int progress) {
            setState(() {
              _loadingPercentage = progress; // Update loading progress
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _loadingPercentage = 100; // Page load complete
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // Load the URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller), // Display WebView
          if (_loadingPercentage < 100)
            LinearProgressIndicator(
              color: const Color(0xff7579FF),
              value: _loadingPercentage / 100.0, // Show progress bar
            ),
        ],
      ),
    );
  }
}
