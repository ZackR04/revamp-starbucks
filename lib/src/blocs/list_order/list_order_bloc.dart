// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starbucks/src/models/models.dart';
import 'package:starbucks/src/services/services.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  ListOrderBloc() : super(ListOrderInitial()) {
    on<FetchListOrder>((event, emit) async {
      emit(ListOrderIsLoading());
      final result = await OrderService().fetchListOrder();
      emit(result.fold(
          (l) => ListOrderIsFailed(l), (r) => ListOrderIsSuccess(r)));
    });

    on<FetchListOrderbyAdmin>((event, emit) async {
      emit(ListOrderIsLoading());
      final result = await OrderService().fetchListOrderbyAdmin();
      emit(result.fold(
          (l) => ListOrderIsFailed(l), (r) => ListOrderIsSuccess(r)));
    });
  }
}
