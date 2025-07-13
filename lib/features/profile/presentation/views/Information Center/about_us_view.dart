import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/home/presentation/views/services_section/services_section.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/build_text_body_widget.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/build_title_widget.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/contributors_section.dart'
    show ContributorsSection;

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});
  static const String routeName = '/about_us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "About Us"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.h,
            children: const [
              BuildTitleWidget(title: "Who We Are"),
              BuildTextBodyWidget(
                body:
                    "We’re a passionate team behind BidMart, a trusted online platform where users can bid, win, and connect. Whether you're selling unique items or trying to get the best deal, our secure and easy-to-use system empowers everyone to participate confidently.",
              ),
              BuildTitleWidget(title: "Our Mission"),
              BuildTextBodyWidget(
                body:
                    "To make online bidding simple, fair, and accessible for all.",
              ),
              BuildTitleWidget(title: "Why Choose us?"),
              ServicesSection(),
              ContributorsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
