// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginIsFailed) {
            Commons().showSnackBar(context, state.message);
          } else if (state is LoginIsSuccess) {
            context.go(routeName.mainHome);
            // if (state.admin!) {
            //   context.go(routeName.homeAdmin);
            // } else {
            //   context.go(routeName.home);
            // }
          }
        },
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return ZStack(
                [
                  AnimatedPositioned(
                    duration: defaultDuration,
                    width: _size.width * 0.88,
                    height: _size.height,
                    left: _isShowSignUp ? -_size.width * 0.76 : 0,
                    child: Container(
                      color: colorName.primary,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 32, left: 32),
                        child: _buildLoginForm(),
                      )),
                    ),
                  ),

                  // Register
                  AnimatedPositioned(
                    duration: defaultDuration,
                    height: _size.height,
                    width: _size.width,
                    left:
                        _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                    child: Container(
                      color: colorName.brown,
                      child: const RegisterScreen(),
                    ),
                  ),

                  AnimatedPositioned(
                    duration: defaultDuration,
                    top: _size.height * 0.05,
                    left: 0,
                    right: _isShowSignUp
                        ? -_size.width * 0.06
                        : _size.width * 0.06,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/starbucks hijau.png',
                        height: 160,
                        width: 160,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    width: _size.width,
                    bottom: _size.height * 0.1,
                    right: _isShowSignUp
                        ? -_size.width * 0.06
                        : _size.width * 0.06,
                    child: _buildSocialLogin(),
                  ),

                  // Login Text
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _isShowSignUp
                        ? _size.height / 2 - 80
                        : _size.height * 0.2,
                    left: _isShowSignUp ? 0 : _size.width * 0.44 - 80,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.black : Colors.black,
                      ),
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * pi / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            if (_isShowSignUp) {
                              updateView();
                            } else {
                              // Login
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75,
                            ),
                            width: 160,
                            child: Text(
                              'Log In'.toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Register Text
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !_isShowSignUp
                        ? _size.height / 2 - 80
                        : _size.height * 0.2,
                    right: _isShowSignUp ? _size.width * 0.44 - 80 : 0,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: !_isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.black : Colors.black,
                      ),
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (_isShowSignUp) {
                              // Register
                            } else {
                              updateView();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75,
                            ),
                            width: 160,
                            child: Text(
                              'Register'.toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      )),
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {}, icon: Image.asset('assets/images/facebook.png')),
        13.widthBox,
        IconButton(
            onPressed: () {}, icon: Image.asset('assets/images/google.png')),
        13.widthBox,
        IconButton(
            onPressed: () {}, icon: Image.asset('assets/images/apple.png')),
        // 13.widthBox,
        // IconButton(onPressed: () {}, icon: Image.asset('assets/images/linkedin.png')),
      ],
    );
  }

  Widget _buildLoginForm() {
    return VStack(
      [
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
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return ButtonWidget(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoginUser(
                    email: emailController.text,
                    password: passController.text));
              },
              isLoading: (state is LoginIsLoading) ? true : false,
              text: 'Login',
              colorText: colorName.black,
              textSize: 20,
              color: colorName.brown,
            ).wFull(context);
          },
        ),
        // 16.heightBox,
        // 'Register Here'.text.makeCentered().onTap(() {
        //   context.go(routeName.register);
        // }),
      ],
    ).p16();
  }

  // Widget _buildRegister() {
  //   return 'Register Here'.text.makeCentered().onTap(() {
  //     context.go(routeName.register);
  //   });
  // }
}
