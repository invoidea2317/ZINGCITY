import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/logic/bloc/splash_screen_state.dart';

import '../../state_inject_package_names.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState());


  void setToken(String token) {
    emit(state.copyWith(Token: token));
  }

  void removeToken() {
    emit(state.copyWith(Token: null));
  }

  void getToken() {
    emit(state.copyWith(Token: state.Token));
  }

  Future<void> chekToken() async {
    SharedPreferences prefs = await  SharedPreferences.getInstance();
      String? token =  await prefs.getString('token');
       bool? isGuest = await prefs.getBool('isGuest');
    if (token != null) {
      log("Token is ", name: token);
      emit(state.copyWith(Token: token,isGuest: isGuest));
    } else {
      log("Token is null", name: "SplashScreenCubit");
      emit(state.copyWith(Token: null));
    }
  }

}
