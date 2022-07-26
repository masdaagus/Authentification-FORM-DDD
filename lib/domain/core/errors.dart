import 'failures.dart';

class NotAuthenticatedError extends Error {}

class UnExpetedValueError extends Error {
  final ValueFailure valueFailure;
  UnExpetedValueError(this.valueFailure);

  @override
  String toString() =>
      Error.safeToString('UnExpetedValueError(valueFailure: $valueFailure)');
}
