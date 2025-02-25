import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsImages extends StatefulWidget {
  final List<String> imageUrls; // List of image URLs as a parameter

  ProductDetailsImages({required this.imageUrls});

  @override
  _ProductDetailsImagesState createState() => _ProductDetailsImagesState();
}

class _ProductDetailsImagesState extends State<ProductDetailsImages> {
  late String selectedImageUrl;

  @override
  void initState() {
    super.initState();
    selectedImageUrl = widget.imageUrls.isNotEmpty ? widget.imageUrls[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Big Image Section
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: selectedImageUrl.isEmpty
              ? Center(child: Text('No Image Available'))
              : CachedNetworkImage(
            imageUrl: selectedImageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Skeletonizer(
              enabled: true,
              child: Container(
                color: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 10),

        // Thumbnail List Section
        if (widget.imageUrls.isNotEmpty)
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImageUrl = widget.imageUrls[index]; // Update the big image
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImageUrl == widget.imageUrls[index]
                            ? Colors.blue
                            : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrls[index],
                        width: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Skeletonizer(
                          enabled: true,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}