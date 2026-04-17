import 'package:flutter/material.dart';

class AdaptiveImage extends StatelessWidget {
  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final Widget? placeholder;
  final String? semanticLabel;

  const AdaptiveImage({
    super.key,
    required this.source,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.placeholder,
    this.semanticLabel,
  });

  bool get _isAsset => source.startsWith('assets/');

  bool get _isNetwork {
    final uri = Uri.tryParse(source);
    return uri != null && uri.hasScheme;
  }

  Widget _loadingPlaceholder() {
    return placeholder ??
        Container(
          color: const Color(0xFF0D1622),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
  }

  Widget _errorPlaceholder() {
    return placeholder ??
        Container(
          color: const Color(0xFF0D1622),
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image_outlined, color: Colors.white24),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (source.isEmpty) {
      return _errorPlaceholder();
    }

    if (_isAsset) {
      return Image.asset(
        source,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        filterQuality: FilterQuality.medium,
        semanticLabel: semanticLabel,
        errorBuilder: (_, __, ___) => _errorPlaceholder(),
      );
    }

    if (_isNetwork) {
      return Image.network(
        source,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        filterQuality: FilterQuality.medium,
        gaplessPlayback: true,
        semanticLabel: semanticLabel,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _loadingPlaceholder();
        },
        errorBuilder: (_, __, ___) => _errorPlaceholder(),
      );
    }

    return Image.asset(
      source,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      filterQuality: FilterQuality.medium,
      semanticLabel: semanticLabel,
      errorBuilder: (_, __, ___) => _errorPlaceholder(),
    );
  }
}
