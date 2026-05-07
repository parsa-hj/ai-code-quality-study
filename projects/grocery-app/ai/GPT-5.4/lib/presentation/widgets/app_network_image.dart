import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.borderRadius = 24,
    this.height,
    this.width,
  });

  final String imageUrl;
  final BoxFit fit;
  final double borderRadius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        height: height,
        width: width,
        placeholder: (_, __) => Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        ),
        errorWidget: (_, __, ___) => Container(
          color: Theme.of(context).colorScheme.errorContainer,
          child: const Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }
}
