part of 'screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterIsFailed) {
            Commons().showSnackBar(context, state.message);
          } else if (state is RegisterIsSuccess) {
            context.go(routeName.home);
          }
        },
        child: VStack([
          VxBox()
              .size(context.screenWidth, context.percentHeight * 20)
              .color(colorName.primary)
              .bottomRounded(value: 20)
              .make(),
          'Register'.text.headline5(context).make().p16(),
          _buildRegistrationForm(),
        ]),
      )),
    );
  }

  Widget _buildRegistrationForm() {
    return VStack(
      [
        TextFieldWidget(
          controller: usernameController,
          title: 'Name',
        ),
        8.heightBox,
        TextFieldWidget(
          controller: emailController,
          title: 'Email',
        ),
        8.heightBox,
        TextFieldWidget(
          controller: passController,
          title: 'Password',
          isPassword: true,
        ),
        16.heightBox,
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return ButtonWidget(
              onPressed: () {
                BlocProvider.of<RegisterBloc>(context).add(
                  RegisterUser(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passController.text),
                );
              },
              isLoading: (state is RegisterIsLoading) ? true : false,
              text: 'Register',
            ).wFull(context);
          },
        ),
        16.heightBox,
        'Login here'.text.makeCentered().onTap(() {
          context.go(routeName.login);
        })
      ],
    ).p(16);
  }
}
