import 'package:fan/persentation/auth/sign_up_page/sign_up_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/sign_up_bloc/sign_up_bloc.dart';
import '../../../injection.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<SignUpBloc>(),
        child: SignUpBody(),
      ),
    );
  }
}
