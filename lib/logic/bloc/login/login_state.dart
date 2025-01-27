part of 'login_bloc.dart';

class LoginModelState extends Equatable {
  final bool? isLoading;
  final String text;
  final String password;
  final LoginState state;
  final String? time;
  final String? timeLeft;

  const LoginModelState( {
    this.text = '',
    this.password = '1234',
    this.time,
    this.timeLeft,
    this.isLoading,
    // this.text = '',
    // this.password = '',
    // this.text = 'koxopo2388@rockdian.com',
    // this.password = '1234',
    this.state = const LoginStateInitial(),
  });

  LoginModelState copyWith({
    String? text,
    String? password,
    LoginState? state,
    String? time,
    String? timeLeft,
    bool? isLoading,
  }) {
    return LoginModelState(
      text: text ?? this.text,
      password: password ?? this.password,
      state: state ?? this.state,
      time: time ?? this.time,
      timeLeft: timeLeft ?? this.timeLeft,
      isLoading: isLoading ?? this.isLoading
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': text.trim()});
    result.addAll({'password': password});
    // result.addAll({'state': state});

    return result;
  }

  factory LoginModelState.fromMap(Map<String, dynamic> map) {
    return LoginModelState(
      text: map['text'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModelState.fromJson(String source) =>
      LoginModelState.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModelState(username: $text, password: $password, state: $state)';

  @override
  List<Object?> get props => [text, password, state,time,timeLeft,isLoading];
}

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

class LoginStateFormInvalid extends LoginState {
  final Errors error;

  const LoginStateFormInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

class LoginStateLogOutLoading extends LoginState {
  const LoginStateLogOutLoading();
}

class LoginStateLoaded extends LoginState {
  final UserLoginResponseModel user;

  const LoginStateLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateUpdatedProfile extends LoginState {
  final UserLoginResponseModel user;

  const LoginStateUpdatedProfile(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateError extends LoginState {
  final String errorMsg;
  final int statusCode;

  const LoginStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class LoginStateSignOutError extends LoginState {
  final String errorMsg;
  final int statusCode;

  const LoginStateSignOutError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class SendAccountCodeSuccess extends LoginState {
  final String msg;

  const SendAccountCodeSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class LoginStateLogOut extends LoginState {
  final String msg;
  final int statusCode;

  const LoginStateLogOut(this.msg, this.statusCode);

  @override
  List<Object> get props => [msg, statusCode];
}

