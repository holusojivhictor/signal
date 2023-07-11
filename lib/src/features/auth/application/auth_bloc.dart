import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signal/src/features/auth/infrastructure/auth_service.dart';
import 'package:signal/src/features/common/domain/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authService) : super(const AuthState.init()) {
    on<AuthInit>(_onInit);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  final AuthService _authService;

  Future<void> _onInit(AuthInit event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await _authService.loggedIn.then((bool loggedIn) async {
      if (loggedIn) {
        final username = await _authService.username;

        final user = User.emptyWithEmail(username!);

        emit(
          state.copyWith(
            isLoggedIn: true,
            user: user,
            status: AuthStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoggedIn: false,
            status: AuthStatus.loaded,
          ),
        );
      }
    });
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final success = await _authService.login(
      email: event.username,
      password: event.password,
    );

    if (success) {
      emit(
        state.copyWith(
          user: User.emptyWithEmail(event.username),
          isLoggedIn: true,
          status: AuthStatus.loaded,
        ),
      );
    } else {
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        user: const User.empty(),
        isLoggedIn: false,
      ),
    );

    await _authService.logout();
  }
}
