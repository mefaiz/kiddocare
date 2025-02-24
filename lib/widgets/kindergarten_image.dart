import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiddocare/widgets/loading.dart';

// reusable image widget
class KindergartenImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  const KindergartenImage({
    super.key, 
    required this.imageUrl, 
    this.height = 300, 
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        
        // show loading indicator when image is loading
        placeholder: (context, url) => const GlobalLoading(),
        // show error icon when image is not found
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}