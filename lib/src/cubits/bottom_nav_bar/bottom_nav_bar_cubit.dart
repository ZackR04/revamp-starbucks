// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial(0));

  PageController pageController = PageController(initialPage: 0);
  PageController pageSellerController = PageController(initialPage: 0);

  void changeIndex(int newIndex) {
    emit(BottomNavBarInitial(newIndex));
    pageController.animateToPage(newIndex,
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  void changeIndexSeller(int newIndex) {
    emit(BottomNavBarInitial(newIndex));
    pageSellerController.animateToPage(newIndex,
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  void initIndex() {
    emit(BottomNavBarInitial(0));
  }
}
