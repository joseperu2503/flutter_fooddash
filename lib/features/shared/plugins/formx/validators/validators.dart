import './min_validator.dart';
import './validator.dart';

class Validators {
  /// Creates a validator that requires the control's value to be greater than
  /// or equal to [min] value.
  ///
  /// The argument [min] must not be null.
  static Validator<dynamic> min<T>(T min) => MinValidator<T>(min);
}
