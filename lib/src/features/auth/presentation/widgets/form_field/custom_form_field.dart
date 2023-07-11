import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

typedef Validator = String? Function(String?);
typedef OnChanged = void Function(String);

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    super.key,
    this.autoValidate = false,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.errorText,
    this.hintStyle,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Validator? validator;
  final OnChanged? onChanged;
  final String? errorText;
  final TextStyle? hintStyle;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      controller: textEditingController,
      obscureText: obscureText,
      onSaved: (value) {
        textEditingController.text = value ?? '';
      },
      onChanged: onChanged,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        contentPadding: Styles.formFieldPadding,
        border: Styles.formFieldBorder,
        enabledBorder: Styles.formFieldBorder,
        focusedBorder: Styles.focusedFormFieldBorder,
        fillColor: theme.scaffoldBackgroundColor,
        errorText: errorText,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle ?? theme.textTheme.bodyMedium!
                .copyWith(color: AppColors.grey5),
      ),
    );
  }
}
