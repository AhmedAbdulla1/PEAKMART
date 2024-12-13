import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class CustomNavigationBar extends StatefulWidget {
  final List<NavBarItem> items;
  final int initialIndex;
  final ValueChanged<int> onTap;
  final double indicatorHeight;

  const CustomNavigationBar({
    required this.items,
    this.initialIndex = 0,
    required this.onTap,
    this.indicatorHeight = 3.0,
    super.key,
  });

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color unselectedColor =
        theme.bottomNavigationBarTheme.unselectedItemColor ??
            theme.colorScheme.onSurface;
    final Color selectedColor =
        theme.bottomNavigationBarTheme.selectedItemColor ??
            theme.colorScheme.primary;
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: theme.bottomNavigationBarTheme.backgroundColor ??
            theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = _currentIndex == index;

          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: AnimatedContainer(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isSelected ? widget.indicatorHeight : 0,
                    width: isSelected ? 65.w : 0,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: selectedColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(widget.indicatorHeight / 2),
                        bottomRight:
                            Radius.circular(widget.indicatorHeight / 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SvgPicture.asset(
                    item.iconPath,
                    color: isSelected ? selectedColor : unselectedColor,
                    height: 24,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.label,
                    style: getMediumStyle(
                      color: isSelected ? selectedColor : unselectedColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class NavBarItem {
  final String iconPath;
  final String label;

  NavBarItem({required this.iconPath, required this.label});
}
