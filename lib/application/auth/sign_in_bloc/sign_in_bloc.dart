import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:fan/domain/auth/i_auth_facade.dart';
import 'package:fan/domain/auth/value_objects.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/models/user_model.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final IAuthFacade _authFacade;
  SignInBloc(this._authFacade) : super(SignInState.initial()) {
    on<SignInEvent>((event, emit) async {
      await event.map(
        emailChanged: (e) {
          emit(state.copyWith(
            emailAddress: EmailAddress(e.email),
            signInFailureOrSuccess: none(),
          ));
        },
        passwordChanged: (e) {
          emit(state.copyWith(
            password: Password(e.password),
            signInFailureOrSuccess: none(),
          ));
        },
        signIn: (_) async {
          final isEmailV = state.emailAddress.isValid();
          final isPasswordV = state.password.isValid();

          if (isEmailV && isPasswordV) {
            emit(state.copyWith(isLoading: true));
            final _optionOf = await _authFacade.signInEmailAndPassword(
              emailAddress: state.emailAddress,
              password: state.password,
            );

            emit(state.copyWith(
              isLoading: false,
              signInFailureOrSuccess: optionOf(_optionOf),
            ));
          }
        },
      );
    });
  }
}
