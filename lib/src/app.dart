import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/features/app_widget.dart';
import 'package:signal/src/features/common/application/bloc.dart';
import 'package:signal/src/features/common/infrastructure/infrastructure.dart';
import 'package:signal/src/features/home/application/home_bloc.dart';
import 'package:signal/src/features/home/infrastructure/wallet_service.dart';

class SignalApp extends StatelessWidget {
  const SignalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            final walletService = getIt<WalletService>();
            return HomeBloc(walletService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final loggingService = getIt<LoggingService>();
            final preferenceService = getIt<PreferenceService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return AppBloc(
              loggingService,
              preferenceService,
              deviceInfoService,
            )..add(AppInit());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final preferenceService = getIt<PreferenceService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return SettingsBloc(
              preferenceService,
              deviceInfoService,
              ctx.read<AppBloc>(),
            )..add(SettingsInit());
          },
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (ctx, state) => const AppWidget(),
      ),
    );
  }
}
