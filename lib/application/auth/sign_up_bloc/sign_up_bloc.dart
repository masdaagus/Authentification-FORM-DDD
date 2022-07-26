import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:fan/domain/auth/i_auth_facade.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/value_objects.dart';
import '../../../domain/models/user_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final IAuthFacade _authFacade;

  SignUpBloc(this._authFacade) : super(SignUpState.initial()) {
    on<SignUpEvent>((event, emit) async {
      await event.map(
        nameChanged: (e) {
          emit(state.copyWith(
            name: Name(e.name),
            signUpFailureOrSuccess: none(),
          ));
        },
        emailChanged: (e) {
          emit(state.copyWith(
            emailAddress: EmailAddress(e.email),
            signUpFailureOrSuccess: none(),
          ));
        },
        passwordChanged: (e) {
          emit(state.copyWith(
            password: Password(e.password),
            signUpFailureOrSuccess: none(),
          ));
        },
        confirmPasswordChanged: (e) {
          bool isPassword = e.confirmPassword == state.password.getOrCrash();
          emit(state.copyWith(
            isPasswordValid: isPassword,
            signUpFailureOrSuccess: none(),
          ));
        },
        signUp: (_) async {
          final isNameV = state.name.isValid();
          final isEmailV = state.emailAddress.isValid();
          final isPasswordV = state.password.isValid();

          if (isEmailV && isPasswordV && isNameV) {
            emit(state.copyWith(isLoading: true));

            final _opstionOf = await _authFacade.registerEmailAndPassword(
              name: state.name,
              emailAddress: state.emailAddress,
              password: state.password,
            );

            emit(
              state.copyWith(
                signUpFailureOrSuccess: optionOf(_opstionOf),
                isLoading: false,
              ),
            );
          }
        },
      );
    });
  }
}
