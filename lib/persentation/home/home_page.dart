import 'package:fan/domain/models/user_model.dart';
import 'package:fan/persentation/auth/sign_in_page/sign_in_page.dart';
import 'package:fan/persentation/core/constant/colors.dart';
import 'package:fan/persentation/core/constant/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: spacing2),
          padding: const EdgeInsets.symmetric(
            horizontal: spacing2,
            vertical: spacing2,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(spacing1),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black26,
                offset: Offset(4, 4),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _Logo(),
              _FieldUser(tittle: 'Name', field: user.name),
              _FieldUser(tittle: 'Email', field: user.email),
              _FieldUser(tittle: 'IsVerified', field: user.isValid.toString()),
              siboh3,
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.signedOut());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
                child: Text(
                  "LOG OUT",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: spacing3),
                  primary: black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spacing2),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(spacing2),
        child: Image.network(
          'https://logos-marques.com/wp-content/uploads/2021/03/Apple-logo.png',
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class _FieldUser extends StatelessWidget {
  const _FieldUser({
    Key? key,
    required this.field,
    required this.tittle,
  }) : super(key: key);

  final String tittle;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: spacing),
      padding: const EdgeInsets.symmetric(
        vertical: spacing1 / 1.5,
        horizontal: spacing1,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(spacing),
      ),
      child: Text(
        "$tittle = $field",
        style: const TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
