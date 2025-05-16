import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:developer';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    try {
      log('Initializing WebView for URL: ${widget.paymentUrl}');
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              log('WebView: Page started loading: $url');
              setState(() {
                _isLoading = true;
                _hasError = false;
                _errorMessage = null;
              });
            },
            onPageFinished: (String url) {
              log('WebView: Page finished loading: $url');
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              log('WebView: Error: ${error.description}, code: ${error.errorCode}');
              setState(() {
                _isLoading = false;
                _hasError = true;
                _errorMessage =
                    'Error loading payment page: ${error.description}';
              });
            },
            onNavigationRequest: (NavigationRequest request) {
              log('WebView: Navigation request: ${request.url}');
// Parse the URL to check its path
              final uri = Uri.parse(request.url);
              final path = uri.path.toLowerCase();

// Allow payment-related pages
              if (path.startsWith('/payment/') || path.contains('reciet.php')|| request.url.contains('https://checkout.tap.company/')||request.url.contains( 'https://acceptance.sandbox.tap.company/')) {
                return NavigationDecision.navigate;
              }

// Handle success/failure
              if (request.url.contains('success')) {
                Navigator.pop(context, {
                  'payment_status': 'success',
                  'url': request.url,
                });
                return NavigationDecision.prevent;
              } else if (request.url.contains('failure') ||
                  request.url.contains('error')) {
                Navigator.pop(context, {
                  'payment_status': 'failed',
                  'url': request.url,
                });
                return NavigationDecision.prevent;
              }

// For any other page (external navigation), close WebView
              log('WebView: Navigating to external page, closing WebView: ${request.url}');
              Navigator.pop(context, {
                'payment_status': 'navigated_away',
                'url': request.url,
              });
              return NavigationDecision.prevent;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.paymentUrl)).catchError((e) {
          log('WebView: Failed to load request: $e');
          setState(() {
            _isLoading = false;
            _hasError = true;
            _errorMessage = 'Failed to load payment page: $e';
          });
        });
    } catch (e, stack) {
      log('WebView: Initialization error: $e', stackTrace: stack);
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Failed to initialize WebView: $e';
      });
    }
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, {
              'payment_status': 'cancelled',
            });
          },
        ),
      ),
      body: Stack(
        children: [
          if (_hasError && _errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_errorMessage!, textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = false;
                        _isLoading = true;
                      });
                      _initializeWebView();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          else if (_controller != null)
            WebViewWidget(controller: _controller!)
          else
            const Center(child: Text('Initializing WebView...')),
          if (_isLoading && !_hasError)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
