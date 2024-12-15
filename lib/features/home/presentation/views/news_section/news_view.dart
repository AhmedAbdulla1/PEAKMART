import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/domain/models/news_model.dart';
import 'package:peakmart/features/home/presentation/views/news_section/animations_view_model.dart';
import 'package:text_scroll/text_scroll.dart';

class AnimatedNewsContainer extends StatefulWidget {
  const AnimatedNewsContainer({super.key,required this.newsModel,  required this.windowSize});
  final NewsModel newsModel;
  final Size windowSize;

  @override
  _AnimatedNewsContainerState createState() => _AnimatedNewsContainerState();
}

class _AnimatedNewsContainerState extends State<AnimatedNewsContainer> with SingleTickerProviderStateMixin  {
  late AnimationViewModel _viewModel;
  @override
  void initState() {
    print('init ${
      widget.windowSize.width
    }');
    super.initState();
    _viewModel = AnimationViewModel();
    // Start the initial animation
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      _viewModel.startInAnimation(widget.windowSize.width - 16);
    });
  }

  @override
  void dispose() {
    print(
      'dispose'
    );
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentWidth = constraints.maxWidth;
        return Stack(
          children: [
            // Main container feed-in animation
            StreamBuilder<double>(
              stream: _viewModel.positionStream,
              initialData: 0,
              builder: (context, snapshot) {
                print(snapshot.data);
                return AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  left: snapshot.data! - parentWidth,
                  top: 0,
                  onEnd: () {
                    _viewModel.startExpandAnimation();
                  },
                  child: Container(
                    padding:const  EdgeInsetsDirectional.only(
                      start: AppPadding.p10,
                      end: AppPadding.p10
                    ),
                    width: parentWidth,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorManager.newsBarColor,
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ]
                    ),
                    child:  Center(
                      child: TextScroll(
                        widget.newsModel.description,
                        mode: TextScrollMode.endless,
                        velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                        delayBefore: const Duration(seconds: 2),
                        pauseBetween: const Duration(milliseconds: 1000),
                        style: getBoldStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.black,
                        ),
                        intervalSpaces: 20,
                        // fadedBorder: true,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                );
              },
            ),

            // Badge animation (only shows once)
            Positioned(
              top: AppSize.s10,
              left: AppSize.s10,
              child: StreamBuilder<bool>(
                stream: _viewModel.isExpandedStream,
                initialData: false,
                builder: (context, snapshot) {
                  bool isExpanded = snapshot.data ?? false;
                  return AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.linear,
                    width: isExpanded ? AppSize.s90.w : 0,
                    height: AppSize.s32.h,
                    onEnd: () {
                      if (isExpanded) {
                        Future.delayed( Duration(seconds: widget.newsModel.timeShow), () {
                          _viewModel.startCollapseAnimation(parentWidth);
                        });
                      }
                    },
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: svg.Svg('assets/images/news_badge.svg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    alignment: Alignment.center,

                    child: isExpanded
                        ? Text(
                            "News",
                            maxLines: 1,
                            style: getBoldStyle(
                              fontSize: FontSize.s16,
                              color: ColorManager.white,
                            ),
                          )
                        : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
