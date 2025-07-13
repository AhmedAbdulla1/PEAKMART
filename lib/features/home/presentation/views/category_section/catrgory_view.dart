import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/features/home/domain/entity/category_entity.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/category_cubit/category_cubit.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/category_cubit/states.dart';
import 'package:Bid_Mart/features/home/presentation/views/category_section/category_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Fake CategoryEntity for skeleton loading
List<CategoryEntity> fakeCategories = List.generate(
  5,
  (index) => CategoryEntity(
    catId: index,
    catName: 'Category $index',
    image: '',
  ),
);

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    required this.onCategorySelected,
    this.showTitle = true,
    this.selectedCategoryId,
  });

  final Function(int categoryId) onCategorySelected;
  final bool showTitle;
  final int? selectedCategoryId;

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
    if (oldWidget.selectedCategoryId != widget.selectedCategoryId) {
      setState(() {
        if (widget.selectedCategoryId == null) {
          isSelected = List.generate(categoryEntity.length, (index) => false);
        } else {
          isSelected = categoryEntity
              .asMap()
              .map((index, category) =>
                  MapEntry(index, category.catId == widget.selectedCategoryId))
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
        if (state is CategoryLoading || state is CategoryInitial) {
          return Skeletonizer(
            enabled: true,
            enableSwitchAnimation: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: widget.showTitle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Categories",
                      style: getBoldStyle(
                          fontSize: FontSize.s20, color: context.primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: fakeCategories.length,
                    itemBuilder: (context, index) => CategoryItemWidget(
                      category: fakeCategories[index],
                      isSelected: false,
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          );
        }
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
                    style: getBoldStyle(fontSize: FontSize.s20),
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
                      isSelected = List.generate(
                          categoryEntity.length, (index) => false);
                      isSelected[index] = true;
                      setState(() {});
                      widget.onCategorySelected(categoryEntity[index].catId);
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return ErrorWidget('');
      },
    );
  }
}
