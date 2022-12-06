// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starbucks/src/models/models.dart';
import 'package:starbucks/src/services/services.dart';

part 'list_wishlist_event.dart';
part 'list_wishlist_state.dart';

class ListWishlistBloc extends Bloc<ListWishlistEvent, ListWishlistState> {
  ListWishlistBloc() : super(ListWishlistInitial()) {
    on<FetchListWishlist>((event, emit) async {
      emit(ListWishlistIsLoading());
      final result = await ProductService().fetchListWishlist();

      emit(result.fold(
          (l) => ListWishlistIsFailed(l), (r) => ListWishlistIsSuccess(r)));
    });
  }
}
