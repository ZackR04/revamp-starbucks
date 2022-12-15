import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starbucks/src/models/models.dart';
import 'package:starbucks/src/services/services.dart';

part 'detail_order_event.dart';
part 'detail_order_state.dart';

class DetailOrderBloc extends Bloc<DetailOrderEvent, DetailOrderState> {
  DetailOrderBloc() : super(DetailOrderInitial()) {
    on<FetchDetailOrder>((event, emit) async {
      emit(DetailOrderIsLoading());
      final result = await OrderService().fetchDetailOrder(event.docID);
      emit(result.fold((l) => DetailOrderIsFailed(message: l), (r) => DetailOrderIsSuccess(model: r)));
    });
  }
}
