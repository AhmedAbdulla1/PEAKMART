import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'payment_receipt_screen.dart';

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
            onNavigationRequest: (NavigationRequest request) async {
              log('WebView: Navigation request: ${request.url}');
              final uri = Uri.parse(request.url);

              // Check if the URL is the receipt page
              if (request.url.contains('https://hk.herova.net/reciet.php')) {
                // Extract tap_id from the URL
                final queryParams = uri.queryParameters;
                final tapId = queryParams['tap_id'];
                log('tapId: $tapId');
                if (tapId == null) {
                  log('WebView: No tap_id found in URL: ${request.url}');
                  Navigator.pop(context, {
                    'payment_status': 'failed',
                    'url': request.url,
                    'error': 'No tap_id found',
                  });
                  return NavigationDecision.prevent;
                }

                // Call the API to get payment details
                try {
                  final apiUrl =
                      'https://hk.herova.net/payment/ret_pay.php?tap_id=$tapId';
                  log('Calling API: $apiUrl');
                  final response = await http.get(Uri.parse(apiUrl));

                  if (response.statusCode == 200) {
                    final data = jsonDecode(response.body);
                    log('API Response: $data');
                    log('Navigating to PaymentReceiptScreen...');

                    // Use pushReplacement to replace the current screen
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          log('Building PaymentReceiptScreen with data: $data');
                          return PaymentReceiptScreen(paymentData: data);
                        },
                      ),
                    );
                    Navigator.pop(
                        context, result); // Return the result to BidDialog
                    log('Navigation to PaymentReceiptScreen completed.');
                  } else {
                    log('API Error: Status code ${response.statusCode}');
                    Navigator.pop(context, {
                      'payment_status': 'failed',
                      'url': request.url,
                      'error': 'API call failed: ${response.statusCode}',
                    });
                  }
                } catch (e, stack) {
                  log('API Call Error: $e', stackTrace: stack);
                  Navigator.pop(context, {
                    'payment_status': 'failed',
                    'url': request.url,
                    'error': 'API call error: $e',
                  });
                }
                return NavigationDecision.prevent;
              }

              // Allow all other navigation
              return NavigationDecision.navigate;
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
            log('Back button pressed in PaymentWebViewScreen');
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
