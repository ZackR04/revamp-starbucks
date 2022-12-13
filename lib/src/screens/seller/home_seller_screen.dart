part of '../screens.dart';

class HomeScreenSeller extends StatelessWidget {
  const HomeScreenSeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const DashboardSellerView(),
      const AdminScreen(),
      const OrderStatusView(),
      const UserSetting(),
    ];

    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return BottomNavigationBar(
              backgroundColor: colorName.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              selectedItemColor: colorName.black,
              unselectedItemColor: colorName.grey,
              currentIndex: (state as BottomNavBarInitial).index,
              onTap: (value) {
                BlocProvider.of<BottomNavBarCubit>(context).changeIndex(value);
                // if (value == 3) {
                //   BlocProvider.of<ListOrderBloc>(context).add(FetchListOrder());
                // }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/home.png',
                    scale: 24,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/add.png',
                    scale: 17,
                  ),
                  label: 'Tambah Produk',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/clipboard.png',
                    scale: 20,
                  ),
                  label: 'Pesanan',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/notification.png',
                    scale: 20,
                  ),
                  label: 'Profile',
                ),
              ]);
        },
      ),
      body: PageView.builder(
        controller: BlocProvider.of<BottomNavBarCubit>(context).pageController,
        itemCount: pages.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }
}
