import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:fan/domain/auth/i_auth_facade.dart';
import 'package:fan/domain/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;
  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        authCheckRequested: (usr) async {
          final userOption = await _authFacade.getSignedInUser();
          userOption.fold(
            () => emit(const AuthState.unauthenticated()),
            (user) => emit(AuthState.authenticated(user)),
          );
        },
        signedOut: (_) async {
          await _authFacade.signOut();
          emit(const AuthState.unauthenticated());
        },
      );
    });
  }
}
