import 'package:authentication_repository/authentication_repository.dart';
import 'package:chatgram/app/routes/routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc.dart';

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  const App(
      {super.key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (context) {
          return AppBloc(
            authenticationRepository: _authenticationRepository,
          )..add(
              const AppSubsriptionRequested(),
            );
        },
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<AppStatus>(
        state: context.select(
          (AppBloc bloc) => bloc.state.status,
        ),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}