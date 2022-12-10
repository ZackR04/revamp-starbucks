// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminIsLoading extends AdminState {}

class AdminIsSuccess extends AdminState {
  final String message;
  AdminIsSuccess({
    required this.message,
  });
}

class AdminIsFailed extends AdminState {
  final String message;
  AdminIsFailed({
    required this.message,
  });
}

class AdminFetchCategory extends AdminState {
  final List? listCategory;
  final String? valDefault;

  AdminFetchCategory({this.valDefault, this.listCategory});
}

class AdminChangeCategory extends AdminState {
  final String? selectedCategory;

  AdminChangeCategory({this.selectedCategory});
}
