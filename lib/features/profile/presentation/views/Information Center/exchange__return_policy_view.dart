import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/profile/presentation/views/Information%20Center/build_text_body_widget.dart';
import 'package:Bid_Mart/features/profile/presentation/views/Information%20Center/build_title_widget.dart';

class ExchangeReturnPolicyView extends StatelessWidget {
  const ExchangeReturnPolicyView({super.key});
  static const String routeName = '/exchange_return_policy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Exchange & Return Policy"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.h,
            children: const [
              BuildTitleWidget(title: "1.Winning bids are final"),
              BuildTextBodyWidget(
                body:
                    "All winning bids are considered final and binding. Once a bid is won, the buyer is obligated to complete the purchase and cannot cancel or withdraw the bid.",
              ),
              BuildTitleWidget(title: "2. Returns & Exchanges."),
              BuildTextBodyWidget(
                body:
                    "Since products are often sold by individual sellers or third parties, returns and exchanges are subject to the seller’s return policy. Some items may be marked as non-returnable or sold as-is. If the item you received is significantly different from the listing description (e.g. wrong item, damaged item), please contact us within 3 days of delivery.",
              ),
              BuildTitleWidget(title: "3.Disputes & Buyer Protection."),
              BuildTextBodyWidget(
                body:
                    "We offer limited buyer protection in cases of: Misrepresentation of item Item not delivered Item arrives damaged or defective To file a dispute: Contact the seller first through your account dashboard. If unresolved within 3 business days, open a ticket with our support team. Provide clear evidence (photos, tracking details, etc.) We will investigate the claim and respond within 5–7 business days.",
              ),
              BuildTitleWidget(title: "4.Refunds."),
              BuildTextBodyWidget(
                body:
                    "Refunds will only be issued in rare, approved cases. If approved: Refunds will be processed to your original payment method. It may take 7–10 business days depending on your bank/payment provider.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
