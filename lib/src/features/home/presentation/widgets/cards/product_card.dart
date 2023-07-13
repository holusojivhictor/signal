import 'package:flutter/material.dart';
import 'package:signal/src/features/common/domain/assets.dart';
import 'package:signal/src/features/common/presentation/images/svg_asset.dart';
import 'package:signal/src/features/common/presentation/styles.dart';
import 'package:signal/src/features/home/domain/models/models.dart';

const _kPadding = EdgeInsets.only(top: 5, bottom: 5, right: 10);

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.width,
    required this.item,
    super.key,
    this.elevation = 0,
  });

  final Product item;
  final double elevation;
  final double width;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: elevation,
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Styles.defaultBorderRadius,
      ),
      margin: _kPadding,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: Styles.edgeInsetAll10,
                decoration: BoxDecoration(
                  color: const Color(0xFF4D5C6A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgAsset(image: Assets.getSvgPath(item.asset)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.productId,
                    style: textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${item.change.toStringAsFixed(2)} %',
                    style: textTheme.bodyLarge!.copyWith(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
