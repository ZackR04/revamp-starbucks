part of '../../../screens.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorName.primary,
        body: SafeArea(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserIsLoading) {
                return const CircularProgressIndicator(
                  color: colorName.secondary,
                ).centered();
              } else if (state is UserIsSuccess) {
                return ZStack([
                  Container(
                    decoration: const BoxDecoration(
                        color: colorName.secondary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                  ).h(context.percentHeight * 15),
                  VStack(
                    [
                      _buildAppBar(context, state.data),
                      16.heightBox,
                      // _buildMenuButton(context),
                      // 12.heightBox,
                      _buildPromotion(context),
                      16.heightBox,
                      // _buildSpecialMenu(),
                      // 16.heightBox,
                      _buildCoffee(),
                      16.heightBox,
                      _buildNonCoffee(),
                      16.heightBox,
                      _buildMakanan(),
                      16.heightBox,
                      _buildLainlain(),
                    ],
                  ).py12(),
                ]).scrollVertical();
              }
              return 0.heightBox;
            },
          ),
        ),
        floatingActionButton: _buildFloatingActionButton());
  }

  Widget _buildAppBar(BuildContext context, UserModel data) {
    return HStack(
      [
        //USER Profile
        HStack([
          Commons().greeting().richText.size(14).base.withTextSpanChildren([
            data.username!.textSpan.size(20).bold.make(),
          ]).make(),
          16.widthBox,
        ]).expand(),
        VxCircle(
          radius: 56,
          backgroundImage: (data.photoProfile!.isNotEmpty)
              ? DecorationImage(
                  image: NetworkImage(data.photoProfile!),
                  fit: BoxFit.cover,
                )
              : null,
        )
        //ICON Cart
      ],
    ).px20();
  }

  // ignore: unused_element
  Widget _buildMenuButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorName.primary,
          boxShadow: [
            BoxShadow(
              color: colorName.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            )
          ]),
      child: VStack(
        [
          HStack([
            'Your card balance'.text.make().expand(),
            'IDR 30.000'.text.size(20).bold.make()
          ]).px12(),
          const Divider(
            color: colorName.brown,
          ),
          HStack(
            [
              IconButton(
                onPressed: () {
                  // context.go(routeName.walletPath);
                },
                icon: Image.asset('assets/icons/gift-card.png'),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<ListWishlistBloc>(context)
                      .add(FetchListWishlist());
                  context.go(routeName.wishlistPath);
                },
                icon: Image.asset('assets/icons/favourite.png'),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  context.go(routeName.menuPath);
                },
                icon: Image.asset('assets/icons/menu.png'),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  // context.go(routeName.cartPath);
                },
                icon: Image.asset('assets/icons/shop.png'),
                iconSize: 30,
              ),
            ],
            alignment: MainAxisAlignment.spaceBetween,
          ).box.width(context.screenWidth).make()
        ],
      ).p12(),
    ).px24().w(context.screenWidth);
  }

  Widget _buildPromotion(BuildContext context) {
    return VStack([
      CarouselSlider(
              items: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEVlm_nJRc8KojsD3i2JAdvDEX1cntvqGtZQ&usqp=CAU',
                width: context.screenWidth,
                fit: BoxFit.cover,
              ),
            ).px12(),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBwjH9wCQQuiT8bytRICoNSkfzV4fzQqtwsg&usqp=CAU',
                width: context.screenWidth,
                fit: BoxFit.cover,
              ),
            ).px12(),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl02aDN1q0rTAJw5fEvNIZ6MygSr6ncYSz9w&usqp=CAU',
                    width: context.screenWidth,
                    fit: BoxFit.cover,
                  ),
                ).px12(),
          ],
              options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal))
          .box
          .height(context.percentHeight * 15)
          .width(context.screenWidth)
          .make(),
    ]);
  }

  Widget _buildSpecialMenu() {
    return SectionWidget(
      title: "Today's Promo",
      routeName: routeName.menuPath,
      child: BlocConsumer<ListProductBloc, ListProductState>(
        listener: (context, state) {
          if (state is ListProductIsFailed) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ListProductIsLoading) {
            //Loading Widget
            return const CircularProgressIndicator(
              color: colorName.secondary,
            );
          }
          if (state is ListProductIsSuccess) {
            //List Product Widget

            return GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 0.1,
                mainAxisSpacing: 0.1,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return GridProductWidget(
                  pictures: state.products[index].pictures?.first,
                  name: state.products[index].name,
                  price: state.products[index].price,
                  id: state.products[index].id,
                );
                //_buildProductWidget(context, state.products[index]);
              },
            ).box.height(135).make();
          }
          return 0.heightBox;
        },
      ),
    ).px16();
  }

  Widget _buildCoffee() {
    return SectionWidget(
      title: "Coffee",
      routeName: routeName.menuPath,
      child: BlocConsumer<ListProductBloc, ListProductState>(
        listener: (context, state) {
          if (state is ListProductIsFailed) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ListProductIsLoading) {
            //Loading Widget
            return const CircularProgressIndicator(
              color: colorName.secondary,
            );
          }
          if (state is ListProductIsSuccess) {
            List<ProductModel> data = state.products
                .where((element) => element.category == 'Coffee')
                .toList();
            //List Product Widget
            return data.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 0.1,
                      mainAxisSpacing: 0.1,
                    ),
                    // itemCount: state.products.where((o) => o.category == 'Coffee').length,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GridProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  ).box.height(135).make()
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ).px16();
  }

  Widget _buildNonCoffee() {
    return SectionWidget(
      title: "Non-Coffee",
      routeName: routeName.menuPath,
      child: BlocConsumer<ListProductBloc, ListProductState>(
        listener: (context, state) {
          if (state is ListProductIsFailed) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ListProductIsLoading) {
            //Loading Widget
            return const CircularProgressIndicator(
              color: colorName.secondary,
            );
          }
          if (state is ListProductIsSuccess) {
            List<ProductModel> data = state.products
                .where((element) => element.category == 'Non-Coffee')
                .toList();
            //List Product Widget
            return data.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 0.1,
                      mainAxisSpacing: 0.1,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GridProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  ).box.height(135).make()
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ).px16();
  }

  Widget _buildMakanan() {
    return SectionWidget(
      title: "Makanan",
      routeName: routeName.menuPath,
      child: BlocConsumer<ListProductBloc, ListProductState>(
        listener: (context, state) {
          if (state is ListProductIsFailed) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ListProductIsLoading) {
            //Loading Widget
            return const CircularProgressIndicator(
              color: colorName.secondary,
            );
          }
          if (state is ListProductIsSuccess) {
            List<ProductModel> data = state.products
                .where((element) => element.category == 'Makanan')
                .toList();
            //List Product Widget
            return data.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 0.1,
                      mainAxisSpacing: 0.1,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GridProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  ).box.height(135).make()
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ).px16();
  }

  Widget _buildLainlain() {
    return SectionWidget(
      title: "Lain-lain",
      routeName: routeName.menuPath,
      child: BlocConsumer<ListProductBloc, ListProductState>(
        listener: (context, state) {
          if (state is ListProductIsFailed) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ListProductIsLoading) {
            //Loading Widget
            return const CircularProgressIndicator(
              color: colorName.secondary,
            );
          }
          if (state is ListProductIsSuccess) {
            List<ProductModel> data = state.products
                .where((element) => element.category == 'Lain-lain')
                .toList();

            //List Product Widget
            return data.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 0.1,
                      mainAxisSpacing: 0.1,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GridProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  ).box.height(135).make()
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ).px16();
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<CartCountCubit, CartCountState>(
      builder: (context, state) {
        return ZStack(
          [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: IconButton(
                onPressed: () {
                  context.go(routeName.cartPath);
                },
                icon: Image.asset(
                  'assets/icons/hot-drink.png',
                  color: colorName.white,
                ),
              ).box.color(colorName.secondary).make(),
            ),
            (state is CartCountIsSuccess)
                ? (state.value != 0)
                    ? VxBox(
                            child: state.value.text
                                .size(8)
                                .white
                                .makeCentered()
                                .p4())
                        .roundedFull
                        .color(colorName.accentRed)
                        .make()
                        .positioned(right: 8, top: 2)
                    : 0.heightBox
                : 0.heightBox,
          ],
          alignment: Alignment.topRight,
        );
      },
    );
  }

  // Widget _buildProductWidget(BuildContext context, ProductModel data) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: VStack(
  //       [
  //         AspectRatio(
  //           aspectRatio: 16 / 10,
  //           child: Image.network(
  //             data.pictures![0],
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         VStack([
  //           data.name!.text.size(16).bold.make(),
  //           4.heightBox,
  //           Commons().setPriceToIDR(data.price!).text.size(12).make(),
  //         ]).p8()
  //       ],
  //     ).box.white.make(),
  //   ).onTap(() {
  //     context.go(routeName.detailPath, extra: data.id);
  //   });
  // }
}
