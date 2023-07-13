import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/common/domain/models/data/user/user.dart';

import '../../../mocks.dart';

void main() {
  final authService = MockAuthService();

  group(
    'AuthBloc',
    () {
      setUp(() {
        when(() => authService.loggedIn).thenAnswer((_) async => false);
      });

      test(
        'initial state is AuthState.init',
        () => expect(
          AuthBloc(authService).state,
          const AuthState.init(),
        ),
      );
    },
  );

  group('AuthStarted', () {
    const username = 'username';
    const password = 'password';
    setUp(() {
      when(() => authService.username)
          .thenAnswer((_) => Future<String?>.value(username));
      when(() => authService.password).thenAnswer((_) async => password);
      when(() => authService.loggedIn).thenAnswer((_) async => false);
    });

    blocTest<AuthBloc, AuthState>(
      'initialize',
      build: () => AuthBloc(authService)..add(AuthInit()),
      skip: 1,
      expect: () => <AuthState>[
        const AuthState.init().copyWith(
          status: AuthStatus.loaded,
        ),
      ],
      verify: (_) {
        verify(() => authService.loggedIn).called(1);
        verifyNever(() => authService.username);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'sign in',
      setUp: () {
        when(
          () => authService.login(
            email: username,
            password: password,
          ),
        ).thenAnswer((_) async => true);
      },
      build: () => AuthBloc(authService),
      act: (bloc) => bloc
        ..add(
          AuthLogin(
            username: username,
            password: password,
          ),
        ),
      expect: () => <AuthState>[
        const AuthState(
          user: User.empty(),
          isLoggedIn: false,
          status: AuthStatus.loading,
        ),
        const AuthState(
          user: User.emptyWithEmail(username),
          isLoggedIn: true,
          status: AuthStatus.loaded,
        ),
      ],
      verify: (_) {
        verify(
          () => authService.login(
            email: username,
            password: password,
          ),
        ).called(1);
      },
    );
  });
}
