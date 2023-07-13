import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/extensions/extensions.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/common/domain/assets.dart';
import 'package:signal/src/features/common/presentation/images/svg_asset.dart';
import 'package:signal/src/features/common/presentation/styles.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: theme.scaffoldBackgroundColor,
        child: ClipRRect(
          borderRadius: Styles.stadiumBorder,
          child: Image.asset(Assets.profile),
        ),
      ),
      title: BlocBuilder<AuthBloc, AuthState>(
        bloc: getIt<AuthBloc>(),
        buildWhen: (_, __) => false,
        builder: (_, state) => Text(
          'Hey, ${state.username.capitalize}',
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: const Text('Welcome back'),
      trailing: GestureDetector(
        onTap: context.development,
        child: const SvgAsset(image: Assets.notification),
      ),
    );
  }
}
