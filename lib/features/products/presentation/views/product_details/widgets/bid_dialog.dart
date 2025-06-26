import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

// Placeholder routes (replace with your actual routes)
const String bidRulesRoute = '/bid_rules';
const String contactUsRoute = '/contact_us';

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
  bool _isProcessingPayment = false;
  DateTime? _lastButtonPress;

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
        _enteredBid = null;
      } else {
        _errorMessage = null;
        _enteredBid = bid;
      }
    });
  }

  Future<void> _initiatePayment(BuildContext context) async {
    final now = DateTime.now();
    if (_lastButtonPress != null &&
        now.difference(_lastButtonPress!).inMilliseconds < 1000) {
      log('Button press ignored: too soon');
      return;
    }
    _lastButtonPress = now;

    log('Initiating payment...');
    if (_enteredBid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid bid')),
      );
      return;
    }

    setState(() {
      _isProcessingPayment = true;
    });
    Navigator.pop(context, {
      'bid': _enteredBid,
      'bid_status': "success",
    });
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
// Header
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'The highest bid for this product currently is ',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.higherPrice}\$',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: context.isDarkMode
                          ? ColorManager.darkModePrimary
                          : ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
// Rules
            const BulletText(
                'You must enter a number larger than the highlighted number'),
            const BulletText(
                'A tax fee of 5% will be added to the number you enter'),
            const BulletText(
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
              style: getRegularStyle(
                fontSize: FontSize.s14,
                color: context.isDarkMode
                    ? ColorManager.darkModePrimary
                    : ColorManager.primary,
              ),
              controller: _bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'YOUR BID',
                hintText: 'This price may change after (7s)',
                errorText: _errorMessage,
              ),
              onChanged: _validateBid,
            ),
            SizedBox(height: 12.h),
// Bid Button
            Center(
              child: ElevatedButton(
                onPressed: (_enteredBid != null &&
                        _enteredBid! > widget.higherPrice &&
                        !_isProcessingPayment)
                    ? () => _initiatePayment(context)
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

// Bullet point widget
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
          style: getRegularStyle(fontSize: FontSize.s14),
        ),
        Expanded(
          child: Text(
            text,
            style: getRegularStyle(fontSize: FontSize.s14),
          ),
        ),
      ],
    );
  }
}

// Bullet point with link
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
          style: getRegularStyle(fontSize: FontSize.s14),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                text,
                style: getRegularStyle(fontSize: FontSize.s14),
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
                    fontSize: FontSize.s15,
                    color: context.isDarkMode
                        ? ColorManager.blueLightest
                        : ColorManager.blue,
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
