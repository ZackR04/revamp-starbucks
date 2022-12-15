part of 'detail_order_bloc.dart';

@immutable
abstract class DetailOrderState {}

class DetailOrderInitial extends DetailOrderState {}

class DetailOrderIsLoading extends DetailOrderState {}

class DetailOrderIsSuccess extends DetailOrderState {
  final OrderModel model;

  DetailOrderIsSuccess({
  required this.model});
}

class DetailOrderIsFailed extends DetailOrderState {
  final String message;

  DetailOrderIsFailed({
    required this.message});
}
