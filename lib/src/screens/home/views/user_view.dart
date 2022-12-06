part of '../../screens.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        radius: 120,
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
                          BlocProvider.of<UserBloc>(context).add(ChangePhoto());
                        }),
                      ),
                    ],
                    alignment: Alignment.center,
                  ),
                  16.heightBox,
                  VStack(
                    [
                      state.data.username!.text.size(16).bold.make(),
                      state.data.email!.text.size(12).make(),
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(LogOutUser());
                      },
                      child: const Text('Logout')),
                ],
                crossAlignment: CrossAxisAlignment.center,
              ).wFull(context).pSymmetric(v: 12);
            }
            return 0.heightBox;
          },
        ).scrollVertical(),
      ),
    );
  }
}
