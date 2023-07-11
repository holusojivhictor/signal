import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

const EdgeInsets _kPadding = EdgeInsets.only(
  top: 16,
  bottom: 8,
);

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    super.key,
    this.text = '',
    this.backgroundColor,
    this.contentPadding,
    this.padding = _kPadding,
    this.hasLoading = false,
    this.enabled = true,
    this.textStyle,
    this.textColor,
    this.child,
    this.side,
  });

  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final BorderSide? side;
  final Widget? child;
  final bool hasLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final style = textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w600,
    );

    final enabledTextColor =
    enabled ? AppColors.white : AppColors.white.withOpacity(0.7);

    final textChild = Text(
      text,
      style: textStyle ?? style.copyWith(color: textColor ?? enabledTextColor),
    );

    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: backgroundColor != null
              ? MaterialStateProperty.all(backgroundColor)
              : MaterialStateProperty.all(
            enabled ? AppColors.primary : AppColors.primary.withOpacity(0.7),
          ),
          shape: MaterialStateProperty.all(
            StadiumBorder(
              side: side ?? BorderSide.none,
            ),
          ),
          padding: MaterialStateProperty.all(
            contentPadding ?? Styles.formFieldPadding,
          ),
        ),
        onPressed: hasLoading || !enabled ? null : onPressed,
        child: hasLoading ? const _LoadingIndicator() : child ?? textChild,
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: AppColors.white,
      ),
    );
  }
}
