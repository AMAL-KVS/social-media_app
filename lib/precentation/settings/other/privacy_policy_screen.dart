import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(
            'https://www.freeprivacypolicy.com/live/8767fb26-0bfd-4e61-bcc6-2bcb08e88a31'),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Privacy Policy'),
          backgroundColor: kwhitecolor,
        ),
        body: SafeArea(child: WebViewWidget(controller: controller)));
  }
}
