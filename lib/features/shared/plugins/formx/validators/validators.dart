import 'package:flutter_fooddash/features/shared/plugins/formx/validators/email_validator.dart';
import 'package:flutter_fooddash/features/shared/plugins/formx/validators/required_validator.dart';

import './min_validator.dart';
import './validator.dart';

class Validators {
  /// Creates a validator that requires the control's value to be greater than
  /// or equal to [min] value.
  ///
  /// The argument [min] must not be null.
  static Validator<T> min<T>(T min) => MinValidator<T>(min);

  /// Creates a validator that requires the control have a non-empty value.
  static Validator<T> required<T>({String? errorMessage}) =>
      RequiredValidator<T>(errorMessage: errorMessage);

  static Validator<T> email<T>({String? errorMessage}) =>
      EmailValidator<T>(errorMessage: errorMessage);
}
