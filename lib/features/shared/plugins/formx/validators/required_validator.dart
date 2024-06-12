import './validator.dart';

/// Validator that requires the control's value to be greater than or equal
/// to a provided value.
class RequiredValidator<T> extends Validator<dynamic> {
  const RequiredValidator({this.errorMessage});

  final String? errorMessage;

  @override
  String? validate(dynamic value) {
    final String error = errorMessage ?? 'This field is required';

    if (value == null) {
      return error;
    } else if (value is String) {
      return value.trim().isEmpty ? error : null;
    }

    return null;
  }
}
