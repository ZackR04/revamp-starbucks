import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'status_order_state.dart';

class StatusOrderCubit extends Cubit<StatusOrderState> {
  StatusOrderCubit() : super(StatusOrderInitial(0));
}
