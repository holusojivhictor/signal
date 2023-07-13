import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

class SettingsSwitchTile extends StatelessWidget {
  const SettingsSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    super.key,
    this.leadingIcon,
    this.onChanged,
  });

  final bool value;
  final String title;
  final String subtitle;
  final Widget? leadingIcon;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.edgeInsetHorizontal16,
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
        ),
        leading: leadingIcon,
        visualDensity: const VisualDensity(vertical: 2),
        contentPadding: const EdgeInsets.only(left: 12),
        trailing: Switch.adaptive(
          activeColor: AppColors.primary,
          value: value,
          onChanged: onChanged != null ? (value) => onChanged!(value) : null,
        ),
      ),
    );
  }
}
