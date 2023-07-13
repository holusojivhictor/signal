import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/common/domain/assets.dart';
import 'package:signal/src/features/common/domain/constants.dart';
import 'package:signal/src/features/common/presentation/colors.dart';

class AnimatedSplash extends StatefulWidget {
  const AnimatedSplash({super.key});

  @override
  State<AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      getIt<AuthBloc>().add(AuthInit());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      builder: (_, state) => Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (state.status == AuthStatus.loading)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      color: AppColors.primary,
                      backgroundColor: theme.scaffoldBackgroundColor,
                    ),
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'ⓒ 2023 Morpheus',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: Constants.splashLogoDimension,
                      height: Constants.splashLogoDimension,
                      child: Image.asset(Assets.loading),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Signal',
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 34,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
