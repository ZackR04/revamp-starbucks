part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderRequest extends OrderEvent {
  final double totalPrice;
  final List<ProductModel> products;

  OrderRequest(
    this.totalPrice,
    this.products,
  );
}
