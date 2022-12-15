// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'status_order_cubit.dart';

@immutable
abstract class StatusOrderState {}

class StatusOrderInitial extends StatusOrderState {
  final int status;
  StatusOrderInitial(
    this.status,
  );
}
