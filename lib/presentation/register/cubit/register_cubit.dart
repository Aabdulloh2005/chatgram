import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chatgram/core/models/user_model.dart';
import 'package:chatgram/core/services/firebase_notification_service.dart';
import 'package:chatgram/core/services/user_service.dart';
import 'package:chatgram/core/utils/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final userService = UserService();
  final AuthenticationRepository _authenticationRepository;
  RegisterCubit(this._authenticationRepository) : super(const RegisterState());

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: FormzSubmissionStatus.initial,
      isValid: Formz.validate(
          [name, state.email, state.password, state.confirmedPassword]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final userInfo = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      String? fcmToken = await FirebaseNotificationService.getFcmToken();
  // UserData.userId = FirebaseAuth.instance.currentUser!.uid;

      await userService.addUser(
        UserModel(
          name: state.name.value,
          email: state.email.value,
          fcmToken: fcmToken,
        ),
        userInfo!.uid,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailFailure catch (e) {
      emit(
        state.copyWith(
            errorMessage: e.message, status: FormzSubmissionStatus.failure),
      );
    } catch (e) {
      emit(
        state.copyWith(status: FormzSubmissionStatus.failure),
      );
    }
  }
}
