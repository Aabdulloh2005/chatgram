import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;

  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AppState(user: authenticationRepository.currentUser)) {
    on<AppSubsriptionRequested>(_onUserSubscriptionRequested);
    on<AppLogOutPressed>(_onLogoutPressed);
  }

  Future<void> _onUserSubscriptionRequested(
      AppSubsriptionRequested event, Emitter<AppState> emit) async {
    return emit.onEach(
      _authenticationRepository.user,
      onData: (user) => emit(AppState(user: user)),
      onError: addError,
    );
  }

  void _onLogoutPressed(
    AppLogOutPressed event,
    Emitter<AppState> emit,
  ) {
    _authenticationRepository.logOut();
  }
}
