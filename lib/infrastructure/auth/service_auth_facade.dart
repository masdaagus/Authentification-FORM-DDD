import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fan/domain/auth/i_auth_facade.dart';
import 'package:fan/domain/models/user_model.dart';
import 'package:fan/domain/auth/value_objects.dart';
import 'package:fan/infrastructure/core/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class ServiceAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  const ServiceAuthFacade(this._firebaseAuth, this._firestore);

  @override
  Future<Option<UserModel>> getSignedInUser() async {
    final userCredential = _firebaseAuth.currentUser;

    if (userCredential != null) {
      final readUser = await _firestore.readUser(userCredential.uid);
      if (readUser != null) {
        final user = UserModel(
          uid: userCredential.uid,
          name: readUser.name,
          email: readUser.email,
          isValid: userCredential.emailVerified,
          password: readUser.password,
        );
        await _firestore.updateUser(user);
        return optionOf(user);
      } else {
        return none();
      }
    } else {
      return none();
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> registerEmailAndPassword({
    required Name name,
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final nameStr = name.getOrCrash().trim();
    final emailStr = emailAddress.getOrCrash().trim();
    final passwordStr = password.getOrCrash().trim();

    try {
      final userredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );

      if (userredential.user != null) {
        await userredential.user!.sendEmailVerification();
        final userModel = UserModel(
          uid: userredential.user!.uid,
          name: nameStr,
          email: emailStr,
          isValid: userredential.user!.emailVerified,
          password: passwordStr,
        );
        await _firestore.createUser(userModel);

        return right(userModel);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signInEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailStr = emailAddress.getOrCrash().trim();
    final passwordStr = password.getOrCrash().trim();

    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
      if (userCredential.user != null) {
        final userModel = UserModel(
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? 'NO NAME',
          email: userCredential.user!.email ?? 'NO-EMAIL',
          isValid: userCredential.user!.emailVerified,
          password: passwordStr,
        );
        return right(userModel);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return left(const AuthFailure.invalidEmailAndPassword());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
