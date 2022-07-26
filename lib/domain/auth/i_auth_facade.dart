import 'package:dartz/dartz.dart';
import 'package:fan/domain/auth/value_objects.dart';

import '../models/user_model.dart';
import 'auth_failure.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, UserModel>> registerEmailAndPassword({
    required Name name,
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, UserModel>> signInEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<void> signOut();

  Future<Option<UserModel>> getSignedInUser();
}
