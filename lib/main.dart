import 'package:authentication_repository/authentication_repository.dart';
import 'package:chatgram/core/di/dependect_injection.dart';
import 'package:chatgram/core/services/firebase_notification_service.dart';
import 'package:chatgram/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  final authenticationRepository = AuthenticationRepository();
  await FirebaseNotificationService.permission();
  await authenticationRepository.user.first;
  setUp();
  runApp(
    App(authenticationRepository: authenticationRepository),
  );
}
