part of '../../screens.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/bg 7.jpg'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.amber.withOpacity(0.15), BlendMode.color),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontSize: 20),
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
                          radius: 90,
                          backgroundImage: (state.data.photoProfile!.isNotEmpty)
                              ? DecorationImage(
                                  image: NetworkImage(state.data.photoProfile!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        IconButton(
                          onPressed: () {},
                          color: colorName.black,
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
                        state.data.username!.text.black.size(22).bold.make(),
                        state.data.email!.text.black.size(18).make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                    _buildUserSettings(context),
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

  Widget _buildUserSettings(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 170),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            // textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.fingerprint,
            size: 50,
            color: Colors.black,
          ),
          label: const Text(
            'Privacy Settings',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      13.heightBox,
      Padding(
        padding: const EdgeInsets.only(right: 190, left: 10),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            // textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.help_center_outlined,
            size: 50,
            color: Colors.black,
          ),
          label: const Text(
            'Help & Support',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      13.heightBox,
      Padding(
        padding: const EdgeInsets.only(right: 260),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            // textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.info_outline_rounded,
            size: 50,
            color: Colors.black,
          ),
          label: const Text(
            'About',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      13.heightBox,
      Padding(
        padding: const EdgeInsets.only(right: 240),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            // textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(LogOutUser());
          },
          icon: const Icon(
            Icons.logout_outlined,
            size: 50,
            color: Colors.black,
          ),
          label: const Text(
            'Logout',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    ]);
  }
}
