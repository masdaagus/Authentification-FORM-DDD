part of 'sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    required EmailAddress emailAddress,
    required Password password,
    required bool isLoading,
    required Option<Either<AuthFailure, UserModel>> signInFailureOrSuccess,
  }) = _SignInState;

  factory SignInState.initial() => SignInState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        isLoading: false,
        signInFailureOrSuccess: none(),
      );
}
