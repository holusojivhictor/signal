import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    required this.title,
    super.key,
    this.trailing = '',
    this.onTap,
  });

  final String title;
  final String trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: Styles.edgeInsetHorizontal16,
      child: ListTile(
        title: Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        dense: true,
        contentPadding: const EdgeInsets.only(left: 12),
        onTap: onTap != null ? () => onTap!() : null,
        trailing: Text(
          trailing,
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }
}
