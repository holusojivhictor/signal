import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.username,
    required this.extra,
  });

  const User.empty()
      : username = '',
        extra = '';

  const User.emptyWithEmail(this.username)
      : extra = '';

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String? ?? '',
        extra = json['extra'] as String? ?? '';

  final String username;
  final String extra;

  @override
  String toString() {
    return 'User $username, $extra';
  }

  @override
  List<Object?> get props => <Object?>[username, extra,];
}
