import 'dart:io';

import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starbucks/src/blocs/blocs.dart';
import 'package:starbucks/src/cubits/cubits.dart';
import 'package:starbucks/src/models/models.dart';
import 'package:starbucks/src/widgets/widgets.dart';
import 'package:starbucks/src/utilities/utilities.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

//
part 'splash_screen.dart';
part 'login_screen.dart';
part 'register_screen.dart';
part 'cart_screen1.dart';
part 'main_home.dart';
//
part 'buyer/cart_screen.dart';
part 'buyer/detailproduct_screen.dart';
part 'buyer/voucher_screen.dart';
part 'buyer/pay_screen.dart';
//
part 'buyer/home/home_screen.dart';
part 'buyer/home/views/dashboard_view.dart';
part 'buyer/home/views/menu_view.dart';
part 'buyer/home/views/notification_view.dart';
part 'buyer/home/views/user_view.dart';
part 'buyer/home/views/wishlist_view.dart';
//
part 'seller/home_seller_screen.dart';
part 'seller/edit_product.dart';
part 'seller/views/dashboard_seller_view.dart';
part 'seller/views/upload_product_view.dart';
part 'seller/views/order_status_view.dart';
part 'seller/views/user_settings_view.dart';



