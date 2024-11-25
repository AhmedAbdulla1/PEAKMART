import 'package:flutter/material.dart';

import 'package:peakmart/features/home/domain/models/category_model.dart';
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories.asMap().entries.map((category) {
          return CategoryItemWidget(
            category: category.value,
            isSelected: isSelected[category.key],
            onTap: () {
              setState(() {
                isSelected = List.generate(widget.categories.length, (index) => false);
                isSelected[category.key] = true;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
