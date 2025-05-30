

import 'package:equatable/equatable.dart';

final class SplashScreenState extends Equatable {
  final String? Token;
  final bool? isGuest;

  const SplashScreenState({this.Token,this.isGuest});


  SplashScreenState copyWith({String? Token, bool? isGuest}) {
    return SplashScreenState(Token: Token ?? this.Token,
        isGuest: isGuest ?? this.isGuest);
  }



  @override
  List<Object?> get props => [Token, isGuest];
}
