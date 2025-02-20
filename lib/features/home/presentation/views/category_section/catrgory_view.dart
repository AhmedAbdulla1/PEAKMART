import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';

import 'package:peakmart/features/home/domain/entity/category_model.dart';
import 'package:peakmart/features/home/presentation/state_m/category_cubit/category_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/category_cubit/states.dart';
import 'package:peakmart/features/home/presentation/views/category_section/category_item_widget.dart';

class CategorySection extends StatefulWidget {
  CategorySection({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(
        title: "Category 1",
        imageUrl: "https://www.svgrepo.com/download/125/car.svg"),
    CategoryModel(
        title: "Category4444444444 2",
        imageUrl: "https://www.svgrepo.com/download/125/car.svg"),
    CategoryModel(
        title: "Category 3",
        imageUrl: "https://www.svgrepo.com/download/125/car.svg"),
    CategoryModel(
        title: "Category 4",
        imageUrl: "https://www.svgrepo.com/download/125/car.svg"),
    CategoryModel(
        title: "Category 5",
        imageUrl: "https://www.svgrepo.com/download/125/car.svg"),
  ];

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  late List<bool> isSelected;

  @override
  @override
  void initState() {
    isSelected = List.generate(widget.categories.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
      if (state is CategoryError) {
        ErrorViewer.showError(
            context: context, error: state.errors, callback: () {});
      }
    }, builder: (context, state) {
      if (state is CategoryLoaded) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: getBoldStyle(
                  fontSize: FontSize.s20, color: ColorManager.grey1),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:state.categoryEntity.categories.length,
              itemBuilder: (context, index) => CategoryItemWidget(
                category: state.categoryEntity.categories[index],
                // isSelected: isSelected[category.key],
                onTap: () {
                  setState(() {
                    isSelected =
                        List.generate(widget.categories.length, (index) => false);
                    // isSelected[state.categoryEntity.categories[index].key] = true;
                  });
                },
              ),
            ),
          ),
        ]);
      } else {
        return const WaitingWidget();
      }
    });
  }
}
