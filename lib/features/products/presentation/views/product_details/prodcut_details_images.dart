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
  late List<String> imageUrls;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrls.isEmpty) {
      imageUrls = [
        // 'https://deelay.me/5000/https://picsum.photos/1200/800', // 5-second delay
        'https://picsum.photos/800/600',
        // Fast-loading image
        'https://picsum.photos/1900/1900',
        // Large image
        "https://imgs.search.brave.com/eAK2XfPpoLbnXT3MZrHRkIGGQR0NtlSJ9PTiW48VDKU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA1LzIxLzAyLzM0/LzM2MF9GXzUyMTAy/MzQ2MF94WXdpT2kx/N1Bub25ueEM1VzQz/U2xqcVdhcUJhUjh3/Zy5qcGc",
        'https://imgs.search.brave.com/4jNLJmyJiU7u36PRgvcwzoOxSKzIj6a_vX20fcIHH0Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTEz/NDM5MzQxL3Bob3Rv/L3BvcnRyYWl0LW9m/LWVudGh1c2lhc3Rp/Yy1idXNpbmVzcy1w/ZW9wbGUtaW4tY2ly/Y2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1veHdzcThX/R0ZUMGl4bVNvam50/WUJFWnFpZm5lNFA3/RGxxT1diWENxV1Vr/PQ',
        'https://imgs.search.brave.com/w2HND3H2u2ORdvuYc96qSZUj_BxcJM2mKSEhQ2E_04I/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA3LzQxLzcxLzkz/LzM2MF9GXzc0MTcx/OTM5NF9DOUJQM1li/aVhTSjdXc3BTREx0/S2RZeFpLS1dsZjBK/ei5qcGc',
        "https://imgs.search.brave.com/HnucNzNI7AHQT2y_JJQkSupdYAMfwkceCfGMy7P0LAI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aXN0b2NrcGhvdG8u/Y29tL3Jlc291cmNl/cy9pbWFnZXMvUGhv/dG9GVExQL1AzLWlT/dG9jay0yMTY0MTU4/MTAzLmpwZw",
        'https://imgs.search.brave.com/4jNLJmyJiU7u36PRgvcwzoOxSKzIj6a_vX20fcIHH0Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTEz/NDM5MzQxL3Bob3Rv/L3BvcnRyYWl0LW9m/LWVudGh1c2lhc3Rp/Yy1idXNpbmVzcy1w/ZW9wbGUtaW4tY2ly/Y2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1veHdzcThX/R0ZUMGl4bVNvam50/WUJFWnFpZm5lNFA3/RGxxT1diWENxV1Vr/PQ',
        'https://imgs.search.brave.com/w2HND3H2u2ORdvuYc96qSZUj_BxcJM2mKSEhQ2E_04I/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA3LzQxLzcxLzkz/LzM2MF9GXzc0MTcx/OTM5NF9DOUJQM1li/aVhTSjdXc3BTREx0/S2RZeFpLS1dsZjBK/ei5qcGc',
      ];
    } else {
      imageUrls = widget.imageUrls;
    }
    selectedImageUrl = imageUrls.isNotEmpty ? imageUrls[0] : '';
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
                      color: Colors.grey[200],
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                ),
        ),
        SizedBox(height: 10),

        // Thumbnail List Section
        if (imageUrls.isNotEmpty&& imageUrls.length>1)
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImageUrl =
                         imageUrls[index]; // Update the big image
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImageUrl == imageUrls[index]
                            ? Colors.blue
                            : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls[index],
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
