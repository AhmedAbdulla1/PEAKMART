import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/payment/domain/entities/payment_entity.dart';
import 'package:peakmart/features/payment/domain/enum/enums.dart';
import 'package:peakmart/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class PaymentReceiptScreen extends StatefulWidget {
  final PaymentEntity paymentData;

  const PaymentReceiptScreen({super.key, required this.paymentData});

  @override
  State<PaymentReceiptScreen> createState() => _PaymentReceiptScreenState();
}

class _PaymentReceiptScreenState extends State<PaymentReceiptScreen> {
  bool _isSaved = false;
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isSaving = false;
  double? _fees;
  double? _total;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
    _calculateFeesAndTotal();
  }

  Future<void> _checkIfSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPaymentId = prefs.getString('saved_receipt_${widget.paymentData.id}');
    setState(() {
      _isSaved = savedPaymentId != null;
    });
  }

  void _calculateFeesAndTotal() {
    final cubit = context.read<PaymentCubit>();
    if (cubit.state is FeesLoaded) {
      final feesEntity = (cubit.state as FeesLoaded).fees;
      final paymentProcess = cubit.paymentProcess;
      final feePercentage = paymentProcess.getFee(feesEntity);
      _fees = widget.paymentData.amount * feePercentage;
      _total = widget.paymentData.amount + (_fees ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.paymentData.status.toString().split('.').last.toUpperCase();
    final amount = widget.paymentData.amount;
    final currency = widget.paymentData.currency;
    final customerName = widget.paymentData.customerName;
    final paymentId = widget.paymentData.id;

    final qrData = 'https://hk.herova.net/reciet.php?tap_id=$paymentId';

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Payment Receipt',
        isNotShowArrowBack: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageAssets.appLogo,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'PAYMENT $status',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 24),
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow('User name', customerName),
                  _buildInfoRow('ID', paymentId),
                  _buildInfoRow('Amount', '$amount $currency'),
                  _buildInfoRow('Fees', _fees != null ? '${_fees!.toStringAsFixed(3)} $currency' : 'N/A'),
                  _buildInfoRow('Total', _total != null ? '${_total!.toStringAsFixed(3)} $currency' : 'N/A'),
                  const SizedBox(height: 24),
                  if (!_isSaved)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: _isSaving ? null : _saveReceipt,
                          color: Colors.blue,
                        ),
                        const Text('Save Receipt'),
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
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
    if (_isSaving) return;
    setState(() {
      _isSaving = true;
    });

    try {
      final image = await _screenshotController.captureFromWidget(
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.appLogo,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 16),
                Text(
                  'PAYMENT ${widget.paymentData.status.toString().split('.').last.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 24),
                QrImageView(
                  data: 'https://hk.herova.net/reciet.php?tap_id=${widget.paymentData.id}',
                  version: QrVersions.auto,
                  size: 150.0,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                ),
                const SizedBox(height: 24),
                _buildInfoRow('User name', widget.paymentData.customerName),
                _buildInfoRow('ID', widget.paymentData.id),
                _buildInfoRow('Amount', widget.paymentData.amount.toString()),
                _buildInfoRow('Fees', _fees?.toStringAsFixed(3) ?? 'N/A'),
                _buildInfoRow('Total', _total?.toStringAsFixed(3) ?? 'N/A'),
              ],
            ),
          ),
        ),
        delay: const Duration(milliseconds: 500),
      );

      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(image),
        quality: 100,
        name: 'receipt_${widget.paymentData.id}',
      );

      if (result['isSuccess']) {
        log('Receipt saved to gallery: ${result['filePath']}');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('saved_receipt_${widget.paymentData.id}', 'true');
        setState(() {
          _isSaved = true;
        });
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
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }
}