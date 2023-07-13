import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/common/application/bloc.dart';
import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/presentation/button/primary_button.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:signal/src/features/settings/presentation/widgets/settings_switch_tile.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (ctx, state) => SettingsSwitchTile(
            title: 'Use dark mode',
            subtitle: 'Light theme still in development',
            value: state.currentTheme.darkMode,
            onChanged: (v) {
              final event = SettingsThemeChanged(
                newValue: AppThemeType.translate(value: v),
              );
              context.read<SettingsBloc>().add(event);
            },
          ),
        ),
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (ctx, state) => SettingsListTile(
            title: 'App version',
            trailing: state.appVersion,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 20,
          ),
          child: PrimaryButton(
            text: 'Log out',
            onPressed: () {
              getIt<AuthBloc>().add(AuthLogout());
            },
            textColor: theme.textTheme.bodyMedium?.color,
            backgroundColor: theme.scaffoldBackgroundColor,
            side: const BorderSide(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
