part of 'sign_up_bloc.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required Name name,
    required EmailAddress emailAddress,
    required Password password,
    required bool isPasswordValid,
    required bool isLoading,
    required Option<Either<AuthFailure, UserModel>> signUpFailureOrSuccess,
  }) = _SignUpState;

  factory SignUpState.initial() => SignUpState(
        name: Name(''),
        emailAddress: EmailAddress(''),
        password: Password(''),
        isPasswordValid: false,
        isLoading: false,
        signUpFailureOrSuccess: none(),
      );
}
