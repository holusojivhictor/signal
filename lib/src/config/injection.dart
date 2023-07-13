import 'package:get_it/get_it.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/auth/infrastructure/auth_service.dart';
import 'package:signal/src/features/common/infrastructure/infrastructure.dart';
import 'package:signal/src/features/home/infrastructure/wallet_service.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final deviceInfoService = DeviceInfoService();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingService();
    getIt.registerSingleton<LoggingService>(loggingService);

    final preferenceService = PreferenceService(loggingService);
    await preferenceService.init();
    getIt.registerSingleton<PreferenceService>(preferenceService);

    final authService = AuthService(preferenceService, loggingService);
    getIt
      ..registerSingleton<AuthService>(authService)
      ..registerSingleton(AuthBloc(authService))
      ..registerSingleton<WalletService>(WalletService());
  }
}
