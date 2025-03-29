import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

class ProductsViewSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;

  const ProductsViewSearchBar({
    super.key,
    required this.onSearch,
    this.hintText = 'Search products...',
  });

  @override
  State<ProductsViewSearchBar> createState() => _ProductsViewSearchBarState();
}

class _ProductsViewSearchBarState extends State<ProductsViewSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
      widget.onSearch(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? ColorManager.black : ColorManager.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
              size: 24,
            ),
            suffixIcon: _hasText
                ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                      size: 24,
                    ),
                    onPressed: () {
                      _controller.clear();
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: context.colorScheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          onSubmitted: (value) {
            widget.onSearch(value);
          },
        ),
      ),
    );
  }
}
