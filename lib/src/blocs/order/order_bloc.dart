// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starbucks/src/models/models.dart';
import 'package:starbucks/src/services/services.dart';
import 'package:starbucks/src/utilities/utilities.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderRequest>((event, emit) async {
      emit(OrderIsLoading());
      OrderModel orderModel = OrderModel(
          uid: await Commons().getUID(),
          dateTime: DateTime.now(),
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          paymentStatus: 0,
          productName: 'Belanja',
          totalPrice: event.totalPrice,
          products: event.products);

      final result = await OrderService().orderProcess(orderModel);
      emit(result.fold((l) => OrderIsFailed(l), (r) => OrderIsSuccess(r)));
    });
  }
}
