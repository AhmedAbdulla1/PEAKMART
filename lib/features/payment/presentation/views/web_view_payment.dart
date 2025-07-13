import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/payment/domain/entities/payment_entity.dart';
import 'package:Bid_Mart/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:Bid_Mart/features/payment/presentation/views/payment_receipt_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final double enteredBid;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.enteredBid,
  });

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
                _errorMessage = 'Error loading payment page: ${error.description}';
              });
            },
            onNavigationRequest: (NavigationRequest request) async {
              log('WebView: Navigation request: ${request.url}');
              final uri = Uri.parse(request.url);

              if (request.url.contains('https://hk.herova.net/reciet.php')) {
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

                try {
                  final cubit = context.read<PaymentCubit>();
                  await cubit.loadPaymentDetails(tapId);
                  final state = cubit.state;
                  if (state is PaymentLoaded) {
                    log('Confirming payment...');
                    await cubit.confirmPayment(); // استدعاء تأكيد الدفع
                    final confirmState = cubit.state;
                    if (confirmState is PaymentSuccess) {
                      log('Navigating to PaymentReceiptScreen with data: ${state.payment}');
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: cubit,
                            child: PaymentReceiptScreen(
                              paymentData: state.payment,
                            ),
                          ),
                        ),
                      );
                      Navigator.pop(context, result);
                      log('Navigation to PaymentReceiptScreen completed.');
                    } else if (confirmState is PaymentError) {
                      log('Payment confirmation error: ${confirmState.message}');
                      Navigator.pop(context, {
                        'payment_status': 'failed',
                        'url': request.url,
                        'error': confirmState.message,
                      });
                    }
                  } else if (state is PaymentError) {
                    log('Payment error: ${state.message}');
                    Navigator.pop(context, {
                      'payment_status': 'failed',
                      'url': request.url,
                      'error': state.message,
                    });
                  }
                } catch (e) {
                  log('API Call Error: $e');
                  Navigator.pop(context, {
                    'payment_status': 'failed',
                    'url': request.url,
                    'error': 'API call error: $e',
                  });
                }
                return NavigationDecision.prevent;
              } else if (request.url.contains('cancel') || request.url.contains('failed')) {
                log('Payment cancelled or failed, returning to start');
                Navigator.pop(context, {
                  'payment_status': 'cancelled',
                  'url': request.url,
                });
                return NavigationDecision.prevent;
              }
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
    } catch (e) {
      log('WebView: Initialization error: $e');
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
      appBar: const CustomAppBar(title: 'Payment'),
      body: Stack(
        children: [
          if (_hasError && _errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_errorMessage!, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
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

extension PaymentEntityToJson on PaymentEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toString().split('.').last,
      'amount': amount,
      'currency': currency,
      'customer': {'first_name': customerName},
      'tapId': tapId,
    };
  }
}