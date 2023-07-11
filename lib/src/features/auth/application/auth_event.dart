part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class AuthInit extends AuthEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class AuthLogin extends AuthEvent {
  AuthLogin({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => <Object?>[username, password,];
}

class AuthLogout extends AuthEvent {
  @override
  List<Object?> get props => <Object?>[];
}
