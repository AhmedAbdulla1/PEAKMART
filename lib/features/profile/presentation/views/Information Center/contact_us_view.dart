import 'package:flutter/material.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});
  static const String routeName = '/contact_us';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Contact Us"),
    );
  }
}
