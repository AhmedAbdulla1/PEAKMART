import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({super.key, required this.imageLink});

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: AppPadding.p10),
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.network(
          imageLink,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: WaitingWidget(),
            );
          },
        ),
      ),
    );
  }
}
