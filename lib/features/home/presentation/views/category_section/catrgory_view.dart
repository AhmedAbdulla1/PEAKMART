import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/domain/entity/category_entity.dart';
import 'package:peakmart/features/home/domain/entity/category_model.dart';
import 'package:peakmart/features/home/presentation/state_m/category_cubit/category_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/category_cubit/states.dart';
import 'package:peakmart/features/home/presentation/views/category_section/category_item_widget.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    required this.onCategorySelected,
    this.showTitle = true,
    this.selectedCategoryId, // Add parameter for the current selected category
  });

  final Function(int categoryId) onCategorySelected;
  final bool showTitle;
  final int? selectedCategoryId; // Current selected category ID

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  late List<bool> isSelected;
  late List<CategoryEntity> categoryEntity;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CategorySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update isSelected when selectedCategoryId changes
    if (oldWidget.selectedCategoryId != widget.selectedCategoryId && categoryEntity != null) {
      setState(() {
        if (widget.selectedCategoryId == null) {
          // Deselect all categories if selectedCategoryId is null
          isSelected = List.generate(categoryEntity.length, (index) => false);
        } else {
          // Update isSelected based on the new selectedCategoryId
          isSelected = categoryEntity
              .asMap()
              .map((index, category) => MapEntry(
              index, category.catId == widget.selectedCategoryId))
              .values
              .toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryError) {
          ErrorViewer.showError(
              context: context, error: state.errors, callback: () {});
        }
        if (state is CategoryLoaded) {
          categoryEntity = state.categoryEntity.categories;
          // Initialize isSelected based on the current selectedCategoryId
          if (widget.selectedCategoryId == null) {
            isSelected = List.generate(categoryEntity.length, (index) => false);
          } else {
            isSelected = categoryEntity
                .asMap()
                .map((index, category) => MapEntry(
                index, category.catId == widget.selectedCategoryId))
                .values
                .toList();
          }
        }
      },
      builder: (context, state) {
        if (state is CategoryLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.showTitle,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Categories",
                    style: getBoldStyle(
                        fontSize: FontSize.s20, color: ColorManager.grey1),
                  ),
                ),
              ),
              SizedBox(
                height: 45.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categoryEntity.categories.length,
                  itemBuilder: (context, index) => CategoryItemWidget(
                    category: state.categoryEntity.categories[index],
                    isSelected: isSelected[index],
                    onTap: () {
                      // Deselect all and select the tapped category
                      isSelected =
                          List.generate(categoryEntity.length, (index) => false);
                      isSelected[index] = true;
                      setState(() {});
                      widget.onCategorySelected(categoryEntity[index].catId);
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is CategoryLoading) {
          return const WaitingWidget();
        } else {
          return  ErrorWidget('');
        }
      },
    );
  }
}