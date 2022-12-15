part of 'utilities.dart';

mixin routeName {
  static const login = '/login';
  static const splash = '/splash';
  static const register = '/register';
  static const home = '/home';
  static const mainHome ='/mainHome';
//
  static const cart = 'cart';
  static const cartPath = '/home/cart';
  static const pay = 'pay';
  static const payPath = '/home/cart/pay';
//
  static const detail = 'detail';
  static const detailPath = '/home/detail';
//
  static const wallet = 'wallet';
  static const walletPath = '/home/wallet';
//
  static const wishlist = 'wishlist';
  static const wishlistPath = '/home/wishlist';
//
  static const menu = 'menu';
  static const menuPath = '/home/menu';

//
  static const homeAdmin = '/homeAdmin';
//
  static const admin = 'admin';
  static const adminPath = '/homeAdmin/admin';
//
  static const edit = 'edit';
  static const editPath = '/homeAdmin/edit';
//
  static const setting = 'setting';
  static const settingPath = '/home/setting';
  static const help = 'help';
  static const helpPath = '/home/setting/help';
  static const about = 'about';
  static const aboutPath = '/home/setting/about';
//
  static const settingSeller = 'setting-seller';
  static const settingSellerPath = '/homeAdmin/setting-seller';
  static const helpSeller = 'help-seller';
  static const helpSellerPath = '/homeAdmin/setting-seller/help-seller';
  static const aboutSeller = 'about-seller';
  static const aboutSellerPath = '/homeAdmin/setting-seller/about-seller';
}

final GoRouter router = GoRouter(initialLocation: routeName.splash, routes: [
  GoRoute(
    path: routeName.splash,
    redirect: (context, state) {
      if (FirebaseAuth.instance.currentUser != null) {
        // Commons().setUID(FirebaseAuth.instance.currentUser!.uid);
        BlocProvider.of<UserBloc>(context).add(LoadUserData());
        return routeName.mainHome;
      } else {
        return routeName.login;
      }
    },
    builder: (context, state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    path: routeName.register,
    builder: (context, state) {
      return const RegisterScreen();
    },
  ),
  GoRoute(
    path: routeName.login,
    builder: (context, state) {
      return const LoginScreen();
    },
  ),
  GoRoute(
      path: routeName.home,
      builder: (context, state) {
        BlocProvider.of<CartCountCubit>(context).getCartCount();
        // BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: routeName.menu,
          builder: (context, state) {
            BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
            return const MenuView();
          },
        ),
        GoRoute(
          path: routeName.cart,
          builder: (context, state) {
            BlocProvider.of<ListCartBloc>(context).add(FetchListCart());
            return const CartScreen();
          },
          routes: [
            GoRoute(
              path: routeName.pay,
              builder: (context, state) {
                // String id = state.extra as String;
                // BlocProvider.of<DetailOrderBloc>(context)
                //     .add(FetchDetailOrder(docID: id));
                return const PayScreen();
              },
            ),
          ]
        ),
        GoRoute(
          path: routeName.setting,
          builder: (context, state) {
            return const UserView();
          },
          routes: [
            GoRoute(
                path: routeName.help,
                builder: (context, state) {
                  return const HelpSupportScreen();
                },
            ),
            GoRoute(
              path: routeName.about,
              builder: (context, state) {
                return const AboutScreen();
              },
            ),
          ]
        ),
        GoRoute(
          path: routeName.detail,
          builder: (context, state) {
            String id = state.extra as String;
            BlocProvider.of<DetailProductBloc>(context)
                .add(FetchDetailProduct(docID: id));
            BlocProvider.of<CheckSavedCubit>(context).checkWishList(id);
            return const DetailProductScreen();
          },
        ),
      ]),
  GoRoute(
    path: routeName.homeAdmin,
    builder: (context, state) {
      // BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
      return const HomeScreenSeller();
    },
      routes: [
        GoRoute(
          path: routeName.edit,
          builder: (context, state) {
            // String id = state.extra as String;
            // BlocProvider.of<DetailProductBloc>(context)
            //     .add(FetchDetailProduct(docID: id));
            return const EditProductScreen();
          },
        ),
        GoRoute(
            path: routeName.settingSeller,
            builder: (context, state) {
              return const UserSetting();
            },
            routes: [
              GoRoute(
                path: routeName.helpSeller,
                builder: (context, state) {
                  return const HelpSupportScreen();
                },
              ),
              GoRoute(
                path: routeName.aboutSeller,
                builder: (context, state) {
                  return const AboutScreen();
                },
              ),
            ]
        ),
      ]
  ),
  GoRoute(
    path: routeName.mainHome,
    builder: (context, state) {
      BlocProvider.of<UserBloc>(context).add(LoadUserData());
      return const MainHome();
    },
  ),
]);
