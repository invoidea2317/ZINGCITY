part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final AgentProfileModel profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;
  final int statusCode;

  const ProfileError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateLoaded extends ProfileState {
  final String message;

  const ProfileUpdateLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileUpdateError extends ProfileState {
  final String message;
  final int statusCode;

  const ProfileUpdateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ProfileUpdateFormValidate extends ProfileState {
  final Errors error;

  const ProfileUpdateFormValidate(this.error);

  @override
  List<Object> get props => [error];
}

class AgentProfileLoaded extends ProfileState {
  final UserProfileModel? users;

  const AgentProfileLoaded(this.users);

  @override
  List<Object> get props => [users!];
}

class AccountDeleting extends ProfileState {
  const AccountDeleting();
}

class AccountDeleted extends ProfileState {
  final String message;

  const AccountDeleted(this.message);

  @override
  List<Object> get props => [message];
}

class AccountDeleteError extends ProfileState {
  final String message;
  final int statusCode;

  const AccountDeleteError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
