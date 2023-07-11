mixin PostDataMixin {
  Map<String, dynamic> toJson();
}

class LoginPostData with PostDataMixin {
  LoginPostData({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}
