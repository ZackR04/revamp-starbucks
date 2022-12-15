part of 'screens.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
        bloc: BlocProvider.of<UserBloc>(context)..add(LoadUserData()),
        listener: (context, state) {
          if (state is UserIsFailed) {
            context.go(routeName.login);
          }
        },
        builder: (context, state) {
          if (state is UserIsSuccess) {
            BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
            BlocProvider.of<BottomNavBarCubit>(context).initIndex();
            if (state.data.admin!) {
              return const HomeScreenSeller();
            } else {
              return const HomeScreen();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
