import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

class ClickableSpan extends StatelessWidget {
  const ClickableSpan({
    required this.leading,
    required this.title,
    super.key,
    this.onTap,
  });

  final String leading;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall!.copyWith(
      fontSize: 13,
      letterSpacing: 0.1,
    );
    return Center(
      child: Padding(
        padding: Styles.edgeInsetVertical10,
        child: Text.rich(
          TextSpan(
            style: style,
            children: <TextSpan>[
              TextSpan(
                text: '$leading ',
              ),
              TextSpan(
                text: title,
                style: style.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
