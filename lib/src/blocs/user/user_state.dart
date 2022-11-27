part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserIsLoading extends UserState {}

class UserIsFailed extends UserState {
  final String message;
  UserIsFailed({
    required this.message,
  });
}

class UserIsSuccess extends UserState {
  final UserModel data;
  UserIsSuccess({
    required this.data,
  });
}

class UserIsLogOut extends UserState {}
