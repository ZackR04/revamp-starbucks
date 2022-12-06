part of '../../screens.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/bg starbucks 2.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.15), BlendMode.darken))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'User Settings',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserIsLogOut) {
                context.go(routeName.login);
              }
            },
            builder: (context, state) {
              if (state is UserIsSuccess) {
                return VStack(
                  [
                    ZStack(
                      [
                        VxCircle(
                          radius: 100,
                          backgroundImage: (state.data.photoProfile!.isNotEmpty)
                              ? DecorationImage(
                                  image: NetworkImage(state.data.photoProfile!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        IconButton(
                          onPressed: () {},
                          color: colorName.white,
                          icon: const Icon(Icons.photo_camera).onTap(() {
                            BlocProvider.of<UserBloc>(context)
                                .add(ChangePhoto());
                          }),
                        ),
                      ],
                      alignment: Alignment.center,
                    ),
                    16.heightBox,
                    VStack(
                      [
                        state.data.username!.text.white.size(22).bold.make(),
                        state.data.email!.text.white.size(18).make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 50, left: 20, top: 90),
                      child: SettingsGroup(iconItemSize: 25, items: [
                        SettingsItem(
                          icons: Icons.fingerprint,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor: Colors.green,
                          ),
                          title: 'Privacy Settings',
                          subtitle: 'Manage Your Privacy Settings',
                          onTap: () {},
                        )
                      ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 50, left: 20, top: 0.05),
                      child: SettingsGroup(iconItemSize: 25, items: [
                        SettingsItem(
                          icons: Icons.info_rounded,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor: Colors.blue,
                          ),
                          title: 'About',
                          subtitle: 'Learn More About Starbucks App',
                          onTap: () {},
                        )
                      ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 50, left: 20, top: 0.05),
                      child: SettingsGroup(iconItemSize: 25, items: [
                        SettingsItem(
                          icons: Icons.exit_to_app_rounded,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor:
                                const Color.fromARGB(255, 230, 42, 29),
                          ),
                          title: 'Logout',
                          onTap: () {
                            BlocProvider.of<UserBloc>(context)
                                .add(LogOutUser());
                          },
                        )
                      ]),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       BlocProvider.of<UserBloc>(context).add(LogOutUser());
                    //     },
                    //     child: const Text('Logout')),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ).wFull(context).pSymmetric(v: 12);
              }
              return 0.heightBox;
            },
          ).scrollVertical(),
        ),
      ),
    );
  }
}
