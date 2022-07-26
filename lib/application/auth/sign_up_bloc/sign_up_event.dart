part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.nameChanged(String name) = _NameChanged;
  const factory SignUpEvent.emailChanged(String email) = _EmailChanged;
  const factory SignUpEvent.passwordChanged(String password) = _PasswordChanged;
  const factory SignUpEvent.confirmPasswordChanged(String confirmPassword) =
      _ConfirmPasswordChanged;

  const factory SignUpEvent.signUp() = _SignUp;
}
