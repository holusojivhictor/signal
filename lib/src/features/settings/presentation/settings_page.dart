import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/settings/presentation/widgets/settings_card.dart';
import 'package:signal/src/routing/app_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: getIt<AuthBloc>(),
        listener: (_, state) {
          if (!state.isLoggedIn) {
            context.go(AppRoute.login.path);
          }
        },
        child: const SafeArea(
          child: SingleChildScrollView(
            child: SettingsCard(),
          ),
        ),
      ),
    );
  }
}
