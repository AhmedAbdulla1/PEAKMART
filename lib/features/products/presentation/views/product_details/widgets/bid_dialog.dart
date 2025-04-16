import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:card_flutter/card_flutter.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

// Placeholder routes for navigation (replace with your actual routes)
const String bidRulesRoute = '/bid_rules';
const String contactUsRoute = '/contact_us';

// Placeholder Tap Payments configuration (replace with your actual values)
const String tapPublicKey =
    'pk_test_your_public_key'; // Replace with your Tap public key

class BidDialog extends StatefulWidget {
  final double higherPrice;

  const BidDialog({
    super.key,
    required this.higherPrice,
  });

  @override
  State<BidDialog> createState() => _BidDialogState();
}

class _BidDialogState extends State<BidDialog> {
  final TextEditingController _bidController = TextEditingController();
  String? _errorMessage;
  double? _enteredBid;

  // TapCard? _tapCard;
  String? _generatedToken;
  bool _isProcessingPayment = false;

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }

  void _validateBid(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorMessage = 'Please enter a bid amount';
        _enteredBid = null;
        return;
      }
      final double? bid = double.tryParse(value);
      if (bid == null) {
        _errorMessage = 'Please enter a valid number';
        _enteredBid = null;
      } else if (bid <= widget.higherPrice) {
        _errorMessage = 'Bid must be greater than ${widget.higherPrice}\$';
        _enteredBid = bid;
      } else {
        _errorMessage = null;
        _enteredBid = bid;
      }
    });
  }

  Future<void> _generateToken() async {
    try {
      // final token = await _tapCard?.generateToken;
      // setState(() {
      //   _generatedToken = token;
      // });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating payment token: $e')),
      );
    }
  }

  Future<void> _initiatePayment(BuildContext context) async {
    if (_enteredBid == null || _generatedToken == null) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // Calculate total amount including 5% tax fee
      final double taxFee = _enteredBid! * 0.05;
      final double totalAmount = _enteredBid! + taxFee;

      // Call your backend to process the payment with the token
      final paymentResult = await _processPaymentWithTap(
        token: _generatedToken!,
        amount: totalAmount,
        currency: 'USD',
        description: 'Bid Payment',
      );

      if (paymentResult['status'] == 'success') {
        Navigator.pop(context, {
          'bid': _enteredBid,
          'payment_status': 'success',
          'transaction_id': paymentResult['transaction_id'],
        });
      } else {
        Navigator.pop(context, {
          'bid': _enteredBid,
          'payment_status': 'failed',
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
      Navigator.pop(context, {
        'bid': _enteredBid,
        'payment_status': 'failed',
      });
    } finally {
      setState(() {
        _isProcessingPayment = false;
      });
    }
  }

  // Placeholder method to process payment via backend
  Future<Map<String, dynamic>> _processPaymentWithTap({
    required String token,
    required double amount,
    required String currency,
    required String description,
  }) async {
    // Implement this method to call your backend API
    // Example backend request (Node.js example):
    /*
    const axios = require('axios');
    const response = await axios.post('https://api.tap.company/v2/charges', {
      amount: amount,
      currency: currency,
      source: { id: token },
      description: description,
    }, {
      headers: { Authorization: `Bearer sk_test_your_secret_key` },
    });
    return {
      'status': response.data.status === 'CAPTURED' ? 'success' : 'failed',
      'transaction_id': response.data.id,
    };
    */
    // For now, return a mock response
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    return {
      'status': 'success',
      'transaction_id': 'mock_transaction_123',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Close Button

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'The highest bid for this product currently is ',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: context.isDarkMode ? ColorManager.white : ColorManager.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.higherPrice}\$',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            // Rules List
            BulletText(
                'You MUST enter a number larger than the highlighted number'),
            BulletText('A tax fee of 5% will be added to the number you enter'),
            BulletText(
                'In case you are the highest bidder and want to cancel 20% of the money won\'t be refunded'),
            BulletTextWithLink(
              text: 'For more details check the ',
              linkText: 'bid rules',
              onTap: () {
                Navigator.pushNamed(context, bidRulesRoute);
              },
            ),
            BulletTextWithLink(
              text: 'or ',
              linkText: 'contact us',
              onTap: () {
                Navigator.pushNamed(context, contactUsRoute);
              },
            ),
            SizedBox(height: 12.h),
            // Bid Input
            TextField(
              controller: _bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'YOUR BID',
                hintText: 'This price may change after (7s)',
                errorText: _errorMessage,
              ),
              onChanged: _validateBid,
            ),
            // Tap Card Input
            // TapCardViewWidget(
            //
            //   tapCardCallBack: (TapCard tapCard) {
            //     _tapCard = tapCard;
            //   },
            //   cardCallBack: (CardCallBack cardCallBack) {
            //     // Optional: Handle card validation status
            //     print('Card validation: ${cardCallBack.toJson()}');
            //   },
            //   apiKey: tapPublicKey,
            //   style: CardStyle(
            //     backgroundColor: ColorManager.white,
            //     borderColor: ColorManager.grey,
            //     borderRadius: 8.r,
            //     borderWidth: 1,
            //     textStyle: getRegularStyle(
            //       fontSize: FontSize.s14,
            //       color: ColorManager.black,
            //     ),
            //   ),
            // ),
            SizedBox(height: 12.h),
            // Bid Button
            Center(
              child: ElevatedButton(
                onPressed: (_enteredBid != null &&
                        _enteredBid! > widget.higherPrice &&
                        !_isProcessingPayment)
                    ? () async {
                        await _generateToken();
                        if (_generatedToken != null) {
                          await _initiatePayment(context);
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: _isProcessingPayment
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Bid',
                        style: getBoldStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for bullet points
class BulletText extends StatelessWidget {
  final String text;

  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: getRegularStyle(
            fontSize: FontSize.s14,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: getRegularStyle(
              fontSize: FontSize.s14,
            ),
          ),
        ),
      ],
    );
  }
}

// Custom widget for bullet points with a clickable link
class BulletTextWithLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const BulletTextWithLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: getRegularStyle(
            fontSize: FontSize.s14,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                text,
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                ),
              ),
              TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  linkText,
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
