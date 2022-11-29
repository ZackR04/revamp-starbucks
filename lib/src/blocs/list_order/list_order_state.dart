part of 'list_order_bloc.dart';

@immutable
abstract class ListOrderState {}

class ListOrderInitial extends ListOrderState {}

class ListOrderIsLoading extends ListOrderState {}

class ListOrderIsSuccess extends ListOrderState {
  final List<OrderModel> model;

  ListOrderIsSuccess(this.model);
}

class ListOrderIsFailed extends ListOrderState {
  final String message;

  ListOrderIsFailed(this.message);
}
