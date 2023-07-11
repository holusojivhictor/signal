import 'package:signal/src/features/common/domain/models/models.dart';
import 'package:signal/src/features/common/infrastructure/infrastructure.dart';

class AuthService extends PostableService {
  AuthService(this._preferenceService, this._logger);

  final PreferenceService _preferenceService;
  final LoggingService _logger;

  Future<bool> get loggedIn async => _preferenceService.loggedIn;

  Future<String?> get username async => _preferenceService.username;

  Future<String?> get password async => _preferenceService.password;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.http(authority, 'api/v1/signin');
    final PostDataMixin data = LoginPostData(
      email: email,
      password: password,
    );

    final success = await performDefaultPost(uri, data);

    if (success) {
      try {
        await _preferenceService.setAuth(
          username: email,
          password: password,
        );
      } catch (_) {
        _logger.error(runtimeType, 'unknown error');
        return false;
      }
    }

    return success;
  }

  Future<void> logout() async {
    await _preferenceService.removeAuth();
  }
}
