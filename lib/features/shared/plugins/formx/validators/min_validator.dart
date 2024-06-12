import './validator.dart';

/// Validator that requires the control's value to be greater than or equal
/// to a provided value.
class MinValidator<T> extends Validator<dynamic> {
  final T min;

  /// Constructs the instance of the validator.
  ///
  /// The argument [min] must not be null.
  const MinValidator(this.min) : super();

  @override
  String? validate(dynamic value) {
    final String error = 'El valor debe ser mayor o igual a $min';

    if (value == null) {
      return error;
    }

    assert(value is Comparable<dynamic>,
        'The MinValidator validator is expecting a control of type `Comparable` but received a control of type ${value.runtimeType}');

    final comparableValue = value as Comparable<dynamic>;
    return comparableValue.compareTo(min) >= 0 ? null : error;
  }
}
