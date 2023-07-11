import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

const double _kIndent = 40;

class FormDivider extends StatelessWidget {
  const FormDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: Styles.edgeInsetVertical10,
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              indent: _kIndent,
              color: AppColors.secondaryShade,
            ),
          ),
          Padding(
            padding: Styles.edgeInsetHorizontal16,
            child: Text(
              'OR',
              style: textTheme.bodySmall!.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              endIndent: _kIndent,
              color: AppColors.secondaryShade,
            ),
          ),
        ],
      ),
    );
  }
}
