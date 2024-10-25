import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth/auth_error_model.dart';
import '../../../data/model/auth/user_login_response_model.dart';
import '../../../presentation/error/failure.dart';
import '../../repository/auth_repository.dart';
import '../../repository/profile_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginModelState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  UserLoginResponseModel? _user;

  bool get isLogedIn => _user != null && _user!.accessToken.isNotEmpty;

  UserLoginResponseModel? get userInfo => _user;

  set user(UserLoginResponseModel userData) => _user = userData;

  LoginBloc({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(const LoginModelState()) {
    on<LoginEvenEmailOrPhone>((event, emit) {
      emit(state.copyWith(text: event.text, state: const LoginStateInitial()));
    });
    on<LoginEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password, state: const LoginStateInitial()));
    });
    on<LoginEventSubmit>(_submitLoginForm);
    on<SentAccountActivateCodeSubmit>(_sentAccountActivateCode);
    on<LoginEventLogout>(_logOut);
    on<LoginEventCheckProfile>(_getUserInfo);

    /// set user data if user already login

    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _user = null,
      (r) {
        user = r;
      },
    );
  }

  Future<void> _getUserInfo(
    LoginEventCheckProfile event,
    Emitter<LoginModelState> emit,
  ) async {
    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _user = null,
      (r) {
        user = r;
        emit(state.copyWith(state: LoginStateLoaded(r)));
      },
    );
  }

  Future<void> _submitLoginForm(
    LoginEventSubmit event,
    Emitter<LoginModelState> emit,
  ) async {
    emit(state.copyWith(state: const LoginStateLoading()));
    final bodyData = state.toMap();

    final result = await _authRepository.login(bodyData);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = LoginStateFormInvalid(failure.errors);
          emit(state.copyWith(state: errors));
        } else {
          final error = LoginStateError(failure.message, failure.statusCode);
          emit(state.copyWith(state: error));
        }
      },
      (user) {
        final loadedData = LoginStateLoaded(user);
        _user = user;
        emit(state.copyWith(state: loadedData));

        emit(state.copyWith(
          text: '',
          password: '',
          state: const LoginStateInitial(),
        ));
      },
    );
  }

  Future<void> _sentAccountActivateCode(
    SentAccountActivateCodeSubmit event,
    Emitter<LoginModelState> emit,
  ) async {
    emit(state.copyWith(state: const LoginStateLoading()));

    final result = await _authRepository.sendActiveAccountCode(state.text);

    result.fold(
      (Failure failure) {
        final error = LoginStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
      (String success) {
        final loadedData = SendAccountCodeSuccess(success);
        emit(state.copyWith(state: loadedData));
      },
    );
  }

  Future<void> _logOut(
    LoginEventLogout event,
    Emitter<LoginModelState> emit,
  ) async {
    emit(state.copyWith(state: const LoginStateLogOutLoading()));

    final result = await _authRepository.logOut(userInfo!.accessToken);

    result.fold(
      (Failure failure) {
        if (failure.statusCode == 500) {
          const loadedData = LoginStateLogOut('logout success', 200);
          emit(state.copyWith(state: loadedData));
        } else {
          final error =
              LoginStateSignOutError(failure.message, failure.statusCode);
          emit(state.copyWith(state: error));
        }
      },
      (String success) {
        _user = null;
        final loadedData = LoginStateLogOut(success, 200);
        emit(state.copyWith(state: loadedData));
      },
    );
  }
}
