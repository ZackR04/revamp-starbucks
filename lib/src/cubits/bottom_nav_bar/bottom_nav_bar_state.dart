// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bottom_nav_bar_cubit.dart';

@immutable
abstract class BottomNavBarState {}

class BottomNavBarInitial extends BottomNavBarState {
  final int index;

  BottomNavBarInitial(this.index);
}
