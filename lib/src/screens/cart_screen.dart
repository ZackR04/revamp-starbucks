part of 'screens.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      body: SafeArea(
        child: VStack([
          _buildAppBar(),
          4.heightBox,
          _buildListCart(),
          _buildTotalPrice(context),
        ]).scrollVertical(),
      ),
    );
  }

  Widget _buildAppBar() {
    return VStack([
      AppBar(
        elevation: 0.0,
        backgroundColor: colorName.primary,
        iconTheme: const IconThemeData(color: colorName.black),
      ),
      'Review Order'.text.size(24).base.bold.make().pSymmetric(v: 4, h: 16),
    ]);
  }

  Widget _buildListCart() {
    return BlocBuilder<ListCartBloc, ListCartState>(
      builder: (context, state) {
        if (state is ListCartIsSuccess) {
          final data = state.data;
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(
              color: colorName.brown,
            ).px16(),
            itemCount: state.retrainData.length,
            itemBuilder: (context, index) {
              List tempList = <ProductModel>[];
              for (var u in data) {
                if (u.variant![0] == state.retrainData[index].variant![0]) {
                  tempList.add(u);
                }
              }

              return VxBox(
                child: HStack([
                  VxCircle(
                    radius: 100,
                    backgroundImage: DecorationImage(
                        image: NetworkImage(
                          state.retrainData[index].pictures![0],
                        ),
                        fit: BoxFit.cover),
                  )
                      .box
                      .size(
                          context.percentWidth * 16, context.percentWidth * 16)
                      .make(),
                  12.widthBox,
                  VStack([
                    state.retrainData[index].name!.text.size(18).bold.make(),
                    4.heightBox,
                    Commons()
                        .setPriceToIDR(state.retrainData[index].price!)
                        .text
                        .size(14)
                        // .bold
                        .make(),
                    state.retrainData[index].variant![0].text
                        .color(colorName.secondary)
                        .size(8)
                        .make()
                        .pSymmetric(v: 4)
                        .box
                        .make(),
                    6.heightBox,
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: colorName.brown.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(10)),
                        child: HStack([
                          const Icon(
                            Icons.remove_outlined,
                            color: colorName.secondary,
                            size: 14,
                          ).onTap(() {
                            BlocProvider.of<ListCartBloc>(context)
                                .add(DecrementCart(state.retrainData[index]));
                          }),
                          4.widthBox,
                          tempList.length.text
                              .size(12)
                              .make()
                              .pSymmetric(h: 12, v: 6),
                          4.widthBox,
                          BlocListener<AddToCartBloc, AddToCartState>(
                            listener: (context, state) {
                              if (state is AddToCartIsSuccess) {
                                BlocProvider.of<ListCartBloc>(context)
                                    .add(FetchListCart());
                              }
                            },
                            child: const Icon(
                              Icons.add_outlined,
                              color: colorName.secondary,
                              size: 14,
                            ).onTap(() {
                              BlocProvider.of<AddToCartBloc>(context).add(
                                  AddToCart(state.retrainData[index],
                                      state.retrainData[index].variant![0]));
                            }),
                          )
                        ]).p2())
                  ]).expand(),
                  BlocListener<WishlistCubit, WishlistState>(
                    listener: (context, wishlistState) {
                      if (wishlistState is WishlistIsSuccess) {
                        Commons().showSnackBar(context, wishlistState.message);
                      }
                      if (wishlistState is WishlistIsFailed) {
                        Commons().showSnackBar(context, wishlistState.message);
                      }
                    },
                    child: BlocBuilder<CheckSavedCubit, CheckSavedState>(
                      builder: (context, checkSavedState) {
                        if (checkSavedState is CheckSavedIsSuccess) {
                          return IconButton(
                              onPressed: () {
                                // BlocProvider.of<WishlistCubit>(context)
                                //     .removeFromWishList(state.data.id!);
                              },
                              icon: const Icon(
                                Icons.bookmark_outlined,
                                color: colorName.brown,
                              ));
                        }
                        return IconButton(
                            onPressed: () {
                              // BlocProvider.of<WishlistCubit>(context)
                              //     .addToWishList(state.data);
                            },
                            icon: const Icon(Icons.bookmark_outlined));
                      },
                    ),
                  )
                ]).p4(),
              ).px8.make();
            },
          );
        }
        return 0.heightBox;
      },
    );
  }

  Widget _buildTotalPrice(BuildContext context) {
    return VStack([
      const Divider(
        color: colorName.brown,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: IconButton(
              onPressed: () {
                context.go(routeName.cartPath);
              },
              icon: const Icon(
                Icons.add_outlined,
                color: colorName.white,
              )).box.color(colorName.secondary).make(),
        ),
      ).pSymmetric(v: 8, h: 12),
    ]);
  }
}
