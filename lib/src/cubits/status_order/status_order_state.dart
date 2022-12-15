// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'status_order_cubit.dart';

@immutable
abstract class StatusOrderState {}

class StatusOrderInitial extends StatusOrderState {}

class ChangeStatus extends StatusOrderInitial {
}

class ChangeStatusFailed extends StatusOrderInitial {
  final String message;

  ChangeStatusFailed(this.message);

}
