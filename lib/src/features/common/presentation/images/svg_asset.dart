import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAsset extends StatelessWidget {
  const SvgAsset({
    required this.image,
    super.key,
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.center,
    this.width,
    this.height,
  });

  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      semanticsLabel: image.split('.').first,
    );
  }
}
