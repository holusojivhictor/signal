import 'package:flutter/material.dart';
import 'package:signal/src/features/auth/presentation/widgets/form_field/custom_form_field.dart';

typedef Validator = String? Function(String?)?;

class FormFieldWithHeader extends StatefulWidget {
  const FormFieldWithHeader({
    required this.controller,
    required this.textInputType,
    required this.header,
    required this.hintText,
    super.key,
    this.autoValidate = false,
    this.obscure = false,
    this.suffixIcon,
    this.errorText,
    this.hintStyle,
    this.validator,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final Validator validator;
  final String header;
  final String hintText;
  final String? errorText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final bool autoValidate;
  final bool obscure;

  @override
  State<FormFieldWithHeader> createState() => _FormFieldWithHeaderState();
}

class _FormFieldWithHeaderState extends State<FormFieldWithHeader> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.header,
              style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomFormField(
          textEditingController: widget.controller,
          obscureText: widget.obscure,
          textInputType: widget.textInputType,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          suffixIcon: widget.suffixIcon,
          errorText: widget.errorText,
          onChanged: (_) => setState(() {}),
          autoValidate: widget.autoValidate,
          validator: widget.validator,
        ),
      ],
    );
  }
}
