// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_product_bloc.dart';

@immutable
abstract class ListProductEvent {}

class FetchListProduct extends ListProductEvent {}
