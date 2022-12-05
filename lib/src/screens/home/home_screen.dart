part of '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const DashboardView(),
      const WalletView(),
      const QRView(),
      const NotificationView(),
      const UserView()
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
                if (value == 3) {
                  BlocProvider.of<ListOrderBloc>(context).add(FetchListOrder());
                }
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
                    'assets/icons/wallet.png',
                    scale: 24,
                  ),
                  label: 'Wallet',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/qr-code-scan.png',
                    scale: 12,
                  ),
                  label: 'QR Scan',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/notification.png',
                    scale: 20,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/user.png',
                    scale: 24,
                  ),
                  label: 'Profile',
                )
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
