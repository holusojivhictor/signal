import 'package:signal/src/features/common/domain/enums/enums.dart';
import 'package:signal/src/features/common/domain/models/models.dart';

const String na = 'N/A';

/// Validator strings
final RegExp emailValidatorRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
const String kEmailNullError = 'Please enter your email.';
const String kInvalidEmailError = 'Please enter a valid email.';
const String kPassNullError = 'Please enter your password.';
const String kShortPassError = 'Your password should be at least 8 characters.';

abstract class Constants {
  static const double splashLogoDimension = 195;

  static const Duration kAnimationDuration = Duration(milliseconds: 200);

  /// Languages map
  static const Map<AppLanguageType, Language> languagesMap = {
    AppLanguageType.english: Language('en', 'US'),
  };
}
