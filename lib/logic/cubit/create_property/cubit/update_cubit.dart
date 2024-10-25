import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../repository/property_repository.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final PropertyRepository _repository;
  final LoginBloc _loginBloc;

  UpdateCubit(
    PropertyRepository repository,
    LoginBloc loginBloc,
  )   : _repository = repository,
        _loginBloc = loginBloc,
        super(UpdateInitial());

  Future<Either> deleteSliderImage(String id) async {
    emit(UpdateStateLoading());
    final result = await _repository.deleteSliderImage(
        id, _loginBloc.userInfo!.accessToken);
    return result;
  }

  Future<Either> deleteSingleNearestLocation(String id) async {
    emit(UpdateStateLoading());

    final result = await _repository.deleteSingleNearestLocation(
        id, _loginBloc.userInfo!.accessToken);
    return result;
  }

  Future<Either> deleteSinglePlan(String id) async {
    emit(UpdateStateLoading());

    final result = await _repository.deleteSinglePlan(
        id, _loginBloc.userInfo!.accessToken);

    return result;
  }

  Future<Either> deleteSingleAddInfo(String id) async {
    emit(UpdateStateLoading());

    final result = await _repository.deleteSingleAddInfo(
        id, _loginBloc.userInfo!.accessToken);

    return result;
  }

  Future<void> deleteProperty(String id) async {
    emit(DeletePropertyLoading());

    final result =
        await _repository.deleteProperty(id, _loginBloc.userInfo!.accessToken);

    result.fold((l) {
      emit(UpdateStateDeleteError(l.message, l.statusCode));
    }, (r) {
      emit(PropertyDeleteSuccess(r));
    });
  }
}
