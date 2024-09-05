import 'package:chatgram/core/utils/app_colors.dart';
import 'package:chatgram/core/widgets/custom_text.dart';
import 'package:chatgram/core/widgets/custom_textfield.dart';
import 'package:chatgram/presentation/register/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
              const Gap(20),
              _NameInput(),
              const Gap(10),
              _EmailInput(),
              const Gap(10),
              _PasswordInput(),
              const Gap(10),
              _ConfirmPasswordInput(),
              const Gap(20),
              _SubmitButton(),
              const Gap(10),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (RegisterCubit cubit) => cubit.state.name.displayError,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(text: "Name"),
        const Gap(5),
        CustomTextfield(
          key: const Key('registerForm_nameInput_textField'),
          prefixIcon:const Icon( Icons.person_outline),
          hintText: 'Name',
          errorText: displayError != null ? 'Invalid name' : null,
          onChanged: (name) => context.read<RegisterCubit>().nameChanged(name),
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (RegisterCubit cubit) => cubit.state.email.displayError,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(text: "Email"),
        const Gap(5),
        CustomTextfield(
          key: const Key('registerForm_emailInput_textField'),
          prefixIcon: const Icon(Icons.email_outlined),
          hintText: 'Email',
          errorText: displayError != null ? 'Invalid email' : null,
          onChanged: (email) =>
              context.read<RegisterCubit>().emailChanged(email),
        ),
      ],
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (RegisterCubit cubit) => cubit.state.password.displayError,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(text: "Password"),
        const Gap(5),
        CustomTextfield(
          key: const Key('registerForm_passwordInput_textField'),
          prefixIcon: const Icon(Icons.lock_outlined),
          hintText: 'Password',
          obscureText: true,
          errorText: displayError != null ? 'Invalid password' : null,
          onChanged: (password) =>
              context.read<RegisterCubit>().passwordChanged(password),
        ),
      ],
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (RegisterCubit cubit) => cubit.state.confirmedPassword.displayError,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(text: "Confirm Password"),
        const Gap(5),
        CustomTextfield(
          key: const Key('registerForm_confirmedPasswordInput_textField'),
          prefixIcon: const Icon(Icons.lock_outlined),
          hintText: 'Confirm Password',
          obscureText: true,
          errorText: displayError != null ? 'Passwords do not match' : null,
          onChanged: (confirmPassword) => context
              .read<RegisterCubit>()
              .confirmedPasswordChanged(confirmPassword),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isValid = context.select(
      (RegisterCubit cubit) => cubit.state.isValid,
    );
    return FloatingActionButton(
      heroTag: "button",
      backgroundColor: isValid ? AppColors.yellow : AppColors.grey,
      onPressed: isValid
          ? () => context.read<RegisterCubit>().signUpFormSubmitted()
          : null,
      child: const CustomText(
        text: "Register",
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('registerForm_loginButton_flatButton'),
      onPressed: () => Navigator.of(context).pop(),
      child: const CustomText(text: "Already have an account? Log In"),
    );
  }
}
