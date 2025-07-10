import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/build_text_body_widget.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/build_title_widget.dart';

class ContributorsSection extends StatelessWidget {
  const ContributorsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.isDarkMode ? ColorManager.black : ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: BuildTitleWidget(
              title: "Contributors",
            )),
            10.vGap,
            ...[
              "Karim Tamer Ali Abo Kamel",
              "Ayman Hamdy Shawky Hussien",
              "Mohammed Abdelfadil Gasser",
              "Ahmed Abdullah Elabassy",
              "Merna Ahmed Ashmawy Ahmed",
              "Abdelrahman Ahmed Moghazy",
              "Adel Salah Elbrolosy",
              "Mostafa Hamada Abdelqodos",
            ].map((name) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 20,
                        color: Colors.cyan,
                      ),
                      10.hGap,
                      Expanded(
                          child: BuildTextBodyWidget(
                        body: name,
                      )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
