part of 'auth_bloc.dart';

enum AuthStatus {
  idle,
  loading,
  loaded,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    required this.user,
    required this.isLoggedIn,
    required this.status,
  });

  const AuthState.init()
      : user = const User.empty(),
        isLoggedIn = false,
        status = AuthStatus.idle;

  final User user;
  final bool isLoggedIn;
  final AuthStatus status;

  String get username => user.username.split('@').first;

  AuthState copyWith({
    User? user,
    bool? isLoggedIn,
    AuthStatus? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    user,
    isLoggedIn,
    status,
  ];
}
