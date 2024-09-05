import 'package:chatgram/app/bloc/app_bloc.dart';
import 'package:chatgram/presentation/home/view/home_screen.dart';
import 'package:chatgram/presentation/login/view/login_screen.dart';
import 'package:flutter/material.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {

    switch (state) {
      case AppStatus.authenticated:
      return [HomeScreen.page()];
      case AppStatus.unauthenticated:
      return [LoginScreen.page()];
    }
}
