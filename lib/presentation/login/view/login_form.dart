import 'package:chatgram/core/utils/app_colors.dart';
import 'package:chatgram/core/widgets/custom_text.dart';
import 'package:chatgram/core/widgets/custom_textfield.dart';
import 'package:chatgram/presentation/login/cubit/login_cubit.dart';
import 'package:chatgram/presentation/register/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (state.status.isInProgress) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Login Failure')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            const Gap(25),
            _EmailInput(),
            const Gap(25),
            _PasswordInput(),
            const Gap(40),
            _LoginButton(),
            const Gap(10),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(RegisterScreen.route());
              },
              child: const CustomText(text: "Don't have account? Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.email.displayError,
    );
    return _buildInput(
      title: "Email",
      hintText: "example@gmail.com",
      prefixIcon: const Icon(Icons.email_outlined),
      errorText: displayError != null ? 'Invalid email' : null,
      onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
      textInputType: TextInputType.emailAddress,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.password.displayError,
    );
    return _buildInput(
      title: "Password",
      hintText: "*******",
      prefixIcon: const Icon(Icons.lock_outlined),
      errorText: displayError != null ? 'Invalid password' : null,
      onChanged: (password) =>
          context.read<LoginCubit>().passwordChanged(password),
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isValid = context.select(
      (LoginCubit cubit) => cubit.state.isValid,
    );
    return FloatingActionButton(
      heroTag: "button",
      backgroundColor: isValid ? AppColors.yellow : AppColors.grey,
      onPressed: isValid
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
      child: const CustomText(
        text: "Log in",
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

Widget _buildInput({
  required String title,
  required String hintText,
  required Icon prefixIcon,
  required String? errorText,
  required ValueChanged<String> onChanged,
  TextInputType? textInputType,
  bool obscureText = false,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(text: title),
      const Gap(5),
      CustomTextfield(
        prefixIcon: prefixIcon,
        hintText: hintText,
        errorText: errorText,
        onChanged: onChanged,
        textInputType: textInputType,
        obscureText: obscureText,
      )
    ],
  );
}
