// ignore_for_file: void_checks, unnecessary_type_check, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SetSplash>((event, emit) async {
      if (event is SetSplash) {
        emit(SplashLoading());
        await Future.delayed(const Duration(seconds: 4));
        emit(SplashLoaded());
      }
    });
  }
}
