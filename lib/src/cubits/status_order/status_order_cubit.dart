// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:starbucks/src/cubits/cubits.dart';
import 'package:starbucks/src/services/services.dart';

part 'status_order_state.dart';

class StatusOrderCubit extends Cubit<StatusOrderState> {
  StatusOrderCubit() : super(StatusOrderInitial());

  void changeStatus(String id, int status) async {
    final result = await OrderService().updatePaymentStatus(id, status);
    emit(result.fold((l) => ChangeStatusFailed(l),
            (r) => ChangeStatus()));
  }
}
