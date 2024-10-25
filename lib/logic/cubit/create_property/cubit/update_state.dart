part of 'update_cubit.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateStateLoading extends UpdateState {}

class DeletePropertyLoading extends UpdateState {}

class UpdateStateError extends UpdateState {
  final String errorMessage;
  final int statusCode;

  const UpdateStateError(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage, statusCode];
}

class UpdateStateDeleteError extends UpdateState {
  final String errorMessage;
  final int statusCode;

  const UpdateStateDeleteError(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage, statusCode];
}

class UpdateStateSuccess extends UpdateState {
  final String message;
  const UpdateStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class PropertyDeleteSuccess extends UpdateState {
  final String message;

  const PropertyDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}
