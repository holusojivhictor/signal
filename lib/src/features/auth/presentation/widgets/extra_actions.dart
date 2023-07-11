import 'package:flutter/material.dart';
import 'package:signal/src/features/auth/presentation/widgets/clickable_span.dart';
import 'package:signal/src/features/common/domain/assets.dart';
import 'package:signal/src/features/common/presentation/images/svg_asset.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

typedef ActionTriggered = void Function()?;

class ExtraActions extends StatelessWidget {
  const ExtraActions({super.key, this.onTap});

  final ActionTriggered onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: Styles.edgeInsetVertical10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTap,
                child: const SvgAsset(image: Assets.google),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: onTap,
                child: const SvgAsset(image: Assets.apple),
              ),
            ],
          ),
        ),
        ClickableSpan(
          leading: "Don't have an account?",
          title: 'Sign up',
          onTap: onTap,
        ),
      ],
    );
  }
}
