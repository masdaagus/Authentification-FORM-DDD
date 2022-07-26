import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fan/persentation/auth/components/form_field.dart';
import 'package:fan/persentation/core/constant/constant.dart';
import '../../../application/auth/sign_up_bloc/sign_up_bloc.dart';

import '../../home/home_page.dart';
import '../components/baground.dart';
import '../components/button_auth.dart';
import '../components/logo_app.dart';
import '../components/signIn_ot_signUp.dart';

class SignUpBody extends StatelessWidget {
  SignUpBody({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BagroundAuth(
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            state.signUpFailureOrSuccess.fold(
              () {},
              (either) => either.fold(
                (fail) => fail.maybeMap(
                  emailAlreadyInUse: (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Email sudah terdaftar")));
                  },
                  serverError: (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Server Error")));
                  },
                  orElse: () => null,
                ),
                (user) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(user: user),
                    ),
                  );
                },
              ),
            );
          },
          builder: (context, state) {
            final bloc = context.read<SignUpBloc>();
            return Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoApp(),
                    siboh3,

                    /// FORM NAME
                    CustomFormField(
                      label: 'Name',
                      onChanged: (val) {
                        bloc.add(SignUpEvent.nameChanged(val));
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Name can't be null";
                        }
                        return state.name.value.fold(
                          (l) => l.maybeMap(
                            shortName: (_) => 'Name lessthan 3 characters',
                            orElse: () => null,
                          ),
                          (_) => null,
                        );
                      },
                    ),

                    /// FORM EMAIL
                    CustomFormField(
                      label: 'Email',
                      onChanged: (val) {
                        bloc.add(SignUpEvent.emailChanged(val));
                      },
                      validator: (val) {
                        if (val!.isEmpty || val.contains('@casso')) {
                          return "Email can't be null";
                        }
                        return state.emailAddress.value.fold(
                          (l) => l.maybeMap(
                            invalidEmail: (_) => 'Invalid Email',
                            orElse: () => null,
                          ),
                          (_) => null,
                        );
                      },
                    ),

                    /// FROM PASSWORD
                    CustomFormField(
                      iconData: Icons.lock_outline,
                      label: 'Password',
                      onChanged: (val) {
                        bloc.add(SignUpEvent.passwordChanged(val));
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password can't be null";
                        }
                        return state.password.value.fold(
                          (l) => l.maybeMap(
                            shortPassword: (_) =>
                                'Password must be contain Uppercase, Lowercase and morethan 8 characters',
                            orElse: () => null,
                          ),
                          (_) => null,
                        );
                      },
                    ),

                    /// FROM CONFIRM PASSWORD
                    CustomFormField(
                      iconData: Icons.lock_outline,
                      label: 'Confirm Password',
                      onChanged: (val) {
                        bloc.add(SignUpEvent.confirmPasswordChanged(val));
                      },
                      validator: (val) {
                        if (val!.isEmpty || !state.isPasswordValid) {
                          return 'Password not match';
                        }
                      },
                    ),

                    siboh3,
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : ButtonAuth(
                            tittle: 'REGISTER',
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_key.currentState!.validate()) {
                                log('VALIDATED');
                                bloc.add(const SignUpEvent.signUp());
                              }
                            },
                          ),
                    siboh3,
                    const SignInOrSignUp(isSign: false),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
