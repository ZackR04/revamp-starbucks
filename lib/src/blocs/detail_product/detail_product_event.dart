// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_product_bloc.dart';

@immutable
abstract class DetailProductEvent {}

class FetchDetailProduct extends DetailProductEvent {
  final String docID;
  FetchDetailProduct({
    required this.docID,
  });
}
