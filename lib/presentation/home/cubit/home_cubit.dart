import 'package:bloc/bloc.dart';
import 'package:chatgram/core/models/user_model.dart';
import 'package:chatgram/core/services/user_service.dart';

part 'home_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService _userService;

  UserCubit(this._userService) : super(UserInitial());

  void loadUsers() {
    emit(UserLoading());

    _userService.getAllUsers().listen(
      (querySnapshot) {
        try {
          final users =
              querySnapshot.docs.map((doc) => UserModel.fromMap(doc)).toList();
          emit(UserLoaded(users));
        } catch (e) {
          emit(UserError('Failed to parse user data: $e'));
        }
      },
      onError: (error) {
        emit(UserError('Failed to load users: $error'));
      },
    );
  }
}
