part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppSubsriptionRequested extends AppEvent {
  const AppSubsriptionRequested();
}

final class AppLogOutPressed extends AppEvent {
  const AppLogOutPressed();
}
