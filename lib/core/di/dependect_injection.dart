import 'package:chatgram/core/services/user_service.dart';
import 'package:chatgram/presentation/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUp() {
  final userService = UserService();
  getIt.registerSingleton(
    UserCubit(userService),
  );

}
