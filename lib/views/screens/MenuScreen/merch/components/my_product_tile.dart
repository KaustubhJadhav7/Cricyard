import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../data/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel productModel;
  final void Function()? onTap;

  const ProductTile(
      {super.key, required this.productModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final heroTag = 'productView_${productModel.id}';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // product image
            SizedBox(
              height: 340,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: mClipper(),
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF219ebc)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.dstOut,
                        ),
                        child: Hero(
                          tag: heroTag,
                          child: Image.network(
                            productModel.image.toString(),
                            width: double.infinity,
                            // fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image,
                                  size: 100, color: Colors.grey);
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        // child: Hero(
                        //   tag: heroTag,
                        //   child: CachedNetworkImage(
                        //     imageUrl: productModel.image.toString(),
                        //     width: double.infinity,
                        //     // Optional: Provide a placeholder while the image loads
                        //     placeholder: (context, url) => const Center(
                        //       child: CircularProgressIndicator(),
                        //     ),
                        //     // Optional: Provide an error widget if the image fails to load
                        //     errorWidget: (context, url, error) => const Icon(
                        //       Icons.broken_image,
                        //       size: 100,
                        //       color: Colors.grey,
                        //     ),
                        //     // fit: BoxFit
                        //     //     .fill, // Uncomment if you want to control the fit
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "${productModel.name}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "Price: \$${productModel.price}",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),

            Text(
              "reviews ${productModel.reviews}",
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Row(
              children: [
                Text(
                  "${productModel.rating}",
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.amber,
                ),
              ],
            ),

            // product name
            // product price
            // product reviews
            // product rating
          ],
        ),
      ),
    );
  }
}

class mClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Starting from middle of the left side
    path.moveTo(0, size.height / 2);

    // Moving to top-right corner
    path.lineTo(size.width, 0);

    // Moving to bottom-right corner
    path.lineTo(size.width, size.height);

    // Moving to bottom-left corner
    path.lineTo(0, size.height);
    // Closing the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Returning false because clipping path is fixed
    return false;
  }
}
