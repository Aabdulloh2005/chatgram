import 'package:authentication_repository/authentication_repository.dart';
import 'package:chatgram/presentation/register/cubit/register_cubit.dart';
import 'package:chatgram/presentation/register/view/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static Route<void> route() {
    return CupertinoPageRoute(
      builder: (context) => const RegisterScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegisterCubit(context.read<AuthenticationRepository>()),
        child: const RegisterForm(),
      ),
    );
  }
}
