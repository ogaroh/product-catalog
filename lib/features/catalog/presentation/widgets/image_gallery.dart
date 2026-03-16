import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/l10n.dart';

/// Horizontally scrollable image gallery for the product detail screen.
class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key, required this.images, this.heroTag});
  final List<String> images;
  final String? heroTag;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Icon(Icons.image_outlined, size: 64, color: Colors.grey),
        ),
      );
    }

    return Semantics(
      label: context.l10n.imageGalleryLabel,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: PageView.builder(
              itemCount: widget.images.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (context, index) {
                final url = widget.images[index];
                final child = CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.broken_image_outlined,
                        size: 48, color: Colors.grey),
                  ),
                );

                // Hero only wraps the first image to match the card thumbnail
                if (index == 0 && widget.heroTag != null) {
                  return Hero(tag: widget.heroTag!, child: child);
                }
                return child;
              },
            ),
          ),
          if (widget.images.length > 1) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _current == i ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _current == i
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
