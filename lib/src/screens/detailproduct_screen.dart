part of 'screens.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorName.white,
        iconTheme: const IconThemeData(color: colorName.black),
      ),
      bottomNavigationBar: BlocBuilder<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          if (state is DetailProductIsSuccess) {
            return BlocConsumer<AddToCartBloc, AddToCartState>(
              listener: (context, addToCartState) {
                if (addToCartState is AddToCartIsSuccess) {
                  Commons().showSnackBar(context, addToCartState.message);
                }
                if (addToCartState is AddToCartIsFailed) {
                  Commons().showSnackBar(context, addToCartState.message);
                }
              },
              builder: (context, addToCartState) {
                return BlocBuilder<CheckVariantCubit, CheckVariantState>(
                  builder: (context, variantState) {
                    return ButtonWidget(
                      text: 'Add To Cart',
                      isLoading: (addToCartState is AddToCartIsLoading),
                      onPressed: () {
                        BlocProvider.of<AddToCartBloc>(context).add(AddToCart(
                            //untuk data
                            state.data,
                            //untuk variant yang dipilih
                            (variantState as CheckVariantIsSelected)
                                .selectedVariant));
                      },
                    ).p16().box.white.withShadow([
                      BoxShadow(
                          blurRadius: 10, color: colorName.grey.withOpacity(.1))
                    ]).make();
                  },
                );
              },
            );
          }
          return 0.heightBox;
        },
      ),
      body: BlocBuilder<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          if (state is DetailProductIsSuccess) {
            return VStack([
              _buildListImage(state),
              50.heightBox,
              _buildProductDetails(state, context),
            ]).scrollVertical();
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildProductDetails(
      DetailProductIsSuccess state, BuildContext context) {
    return VStack([
      HStack([
        VStack([
          state.data.name!.text.size(20).semiBold.make(),
          8.heightBox,
          Commons().setPriceToIDR(state.data.price!).text.size(16).make(),
          8.heightBox,
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
                      BlocProvider.of<WishlistCubit>(context)
                          .removeFromWishList(state.data.id!);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: colorName.accentRed,
                    ));
              }
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<WishlistCubit>(context)
                        .addToWishList(state.data);
                  },
                  icon: const Icon(Icons.favorite_border_rounded));
            },
          ),
        )
      ]),
      ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: colorName.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          HStack(
                            [
                              state.data.name!.text
                                  .size(20)
                                  .center
                                  .semiBold
                                  .make(),
                            ],
                          ),
                          VStack([
                            state.data.desc!.text
                                .size(14)
                                .color(colorName.grey)
                                .center
                                .make(),
                          ]).py16(),
                          16.heightBox,
                          Column(
                            children: const [
                              Text(
                                'Beverage size',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          10.heightBox,
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://e7.pngegg.com/pngimages/951/898/png-clipart-disposable-drinking-cup-illustration-iced-coffee-cafe-coffee-cup-starbucks-free-starbucks-angle-furniture.png',
                                      height: 50,
                                    ),
                                    const Text(
                                      'TALL',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://e7.pngegg.com/pngimages/951/898/png-clipart-disposable-drinking-cup-illustration-iced-coffee-cafe-coffee-cup-starbucks-free-starbucks-angle-furniture.png',
                                      height: 60,
                                    ),
                                    const Text(
                                      'GRANDE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://e7.pngegg.com/pngimages/951/898/png-clipart-disposable-drinking-cup-illustration-iced-coffee-cafe-coffee-cup-starbucks-free-starbucks-angle-furniture.png',
                                      height: 70,
                                    ),
                                    const Text(
                                      'VENTI',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          30.heightBox,
                          Column(
                            children: const [
                              Text(
                                'Variant Product',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          8.heightBox,
                          BlocBuilder<CheckVariantCubit, CheckVariantState>(
                            builder: (context, variantState) {
                              return HStack(state.data.variant!
                                  .map((e) => VxBox(
                                              child: e.text
                                                  .color((variantState
                                                              as CheckVariantIsSelected)
                                                          .selectedVariant
                                                          .contains(e)
                                                      ? colorName.white
                                                      : colorName.black)
                                                  .make())
                                          .color(variantState.selectedVariant
                                                  .contains(e)
                                              ? colorName.secondary
                                              : colorName.white)
                                          .border(
                                              color: variantState
                                                      .selectedVariant
                                                      .contains(e)
                                                  ? colorName.white
                                                  : colorName.grey)
                                          .p16
                                          .rounded
                                          .make()
                                          .onTap(() {
                                        BlocProvider.of<CheckVariantCubit>(
                                                context)
                                            .selectItem(e);
                                      }).pOnly(right: 4))
                                  .toList());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Center(
          child: Text(
            'Customize',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ]).p16();
  }

  Widget _buildListImage(DetailProductIsSuccess state) {
    return VxSwiper.builder(
      itemCount: state.data.pictures!.length,
      autoPlay: true,
      aspectRatio: 16 / 16,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 16 / 16,
          child: Image.network(
            state.data.pictures![index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
