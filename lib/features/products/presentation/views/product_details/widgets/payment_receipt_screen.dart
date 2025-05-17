import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'dart:developer';

class PaymentReceiptScreen extends StatefulWidget {
  final Map<String, dynamic> paymentData;

  const PaymentReceiptScreen({super.key, required this.paymentData});

  @override
  State<PaymentReceiptScreen> createState() => _PaymentReceiptScreenState();
}

class _PaymentReceiptScreenState extends State<PaymentReceiptScreen> {
  bool _isSaved = false;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final status = widget.paymentData['status'] ?? 'CAPTURED';
    final amount = widget.paymentData['amount']?.toString() ?? '1477.14';
    final currency = widget.paymentData['currency'] ?? 'USD';
    final customerName =
        widget.paymentData['customer']?['first_name'] ?? 'astron';
    final paymentId =
        widget.paymentData['id'] ?? 'chg_TS05A3320250017Tg231605704';
    final fees = '73.86'; // يمكن حسابه من الـ API
    final total = '1551.00'; // يمكن حسابه من الـ API

    final qrData = 'https://hk.herova.net/reciet.php?tap_id=$paymentId';

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, {
          'payment_status': 'cancelled',
        });
        return false;
      },
      child: Screenshot(
        controller: _screenshotController,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Payment Receipt'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, {
                  'payment_status': 'cancelled',
                });
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageAssets.appLogo,
                      height: 150,
                      width: 150,
                    ),
                    // const SizedBox(height: 16),
                    Text(
                      'PAYMENT $status',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                    ),
                    _buildInfoRow('User name', customerName),
                    _buildInfoRow('ID', paymentId),
                    _buildInfoRow('Amount', '$amount $currency'),
                    _buildInfoRow('Fees', '$fees $currency'),
                    _buildInfoRow('Total', '$total $currency'),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Save Receipt'),
                        Switch(
                          value: _isSaved,
                          onChanged: (value) async {
                            setState(() {
                              _isSaved = value;
                            });
                            if (_isSaved) {
                              await _saveReceipt();
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'payment_status': 'success',
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B4513),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Future<void> _saveReceipt() async {
    try {
      // أخد السكرينشوت
      final image = await _screenshotController.capture();
      if (image == null) {
        log('Failed to capture screenshot');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to capture receipt!')),
        );
        return;
      }

      // حفظ الصورة في الجاليري باستخدام image_gallery_saver
      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(image),
        quality: 100,
        name: 'receipt_${widget.paymentData['id']}',
      );

      if (result['isSuccess']) {
        log('Receipt saved to gallery: ${result['filePath']}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt saved successfully!')),
        );
      } else {
        log('Failed to save receipt to gallery');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save receipt!')),
        );
      }
    } catch (e) {
      log('Error saving receipt: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving receipt: $e')),
      );
    }
  }
}
