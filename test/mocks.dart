import 'package:mocktail/mocktail.dart';
import 'package:signal/src/features/auth/infrastructure/auth_service.dart';
import 'package:signal/src/features/common/infrastructure/infrastructure.dart';

class MockLoggingService extends Mock implements LoggingService {}

class MockDeviceInfoService extends Mock implements DeviceInfoService {}

class MockPreferenceService extends Mock implements PreferenceService {}

class MockAuthService extends Mock implements AuthService {}

