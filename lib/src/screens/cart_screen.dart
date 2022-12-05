part of 'screens.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      body: SafeArea(
        child: VStack([
          _buildAppBar(context),
          4.heightBox,
          _buildListCart(),
          const Divider(
            color: colorName.brown,
          ).px16(),
          _buildTotalPrice(context),
          _buildPayButton(context),
        ]).scrollVertical(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return VStack([
      AppBar(
        elevation: 0.0,
        backgroundColor: colorName.primary,
        iconTheme: const IconThemeData(color: colorName.black),
      ),
      HStack([
        'Review Order'.text.size(24).base.bold.make().expand(),
        ButtonWidget(
          onPressed: () {
            context.go(routeName.menuPath);
          },
          text: 'Add Items +',
          color: colorName.secondary,
        ),
      ]).pSymmetric(v: 4, h: 16),

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
    return BlocBuilder<ListCartBloc, ListCartState>(
      builder: (context, state) {
        if (state is ListCartIsSuccess) {
          List tempList = <ProductModel>[];

          double cartSubtotal() {
            double total = 0;
            for (var item in state.data) {
              if (item.variant![0] == item.variant![0]) {
                tempList.add(item);
                total += item.price!;
              }
            }
            return total;
          }

          double cartTax() {
            double total = cartSubtotal() * 0.1;
            return total;
          }

          double discount(){
            double total = 0;
            return total;
          }

          double cartTotalPrice() {
            double total = 0;
            total = cartSubtotal() + cartTax() - discount();
            return total;
          }

          return
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorName.white,
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
                      'Summary'.text.size(16).base.bold.make().expand(),
                      'Total ${state.data.length} items'.text.size(16).base.bold.make()
                    ]).px12(),
                    const Divider(
                      thickness: 0.5,
                      color: colorName.brown,
                    ),
                    HStack([
                      'Subtotal: '.text.make().expand(),
                      ''.richText.withTextSpanChildren([
                        Commons()
                            .setPriceToIDR(cartSubtotal())
                            .textSpan
                            .bold
                            .make()
                      ]).make(),
                    ]).pSymmetric(h: 12, v: 4),
                    HStack([
                      'Tax 10%: '.text.make().expand(),
                      ''.richText.withTextSpanChildren([
                        Commons()
                            .setPriceToIDR(cartTax())
                            .textSpan
                            .bold
                            .make()
                      ]).make(),
                    ]).pSymmetric(h: 12, v: 4),
                    HStack([
                      'Discount: '.text.color(colorName.secondary).make().expand(),
                      ''.richText.withTextSpanChildren([
                        Commons()
                            .setPriceToIDR(discount())
                            .textSpan
                            .color(colorName.secondary)
                            .make()
                      ]).make(),
                    ]).pSymmetric(h: 12, v: 4),
                    const Divider(
                      thickness: 1.0,
                      color: colorName.brown,
                    ).px12(),
                    HStack([
                      'Total'.text.size(16).bold.make().expand(),
                      ''.richText.withTextSpanChildren([
                        Commons()
                            .setPriceToIDR(cartTotalPrice())
                            .textSpan
                            .size(16)
                            .bold
                            .make()
                      ]).make(),
                    ]).pSymmetric(h: 12, v: 4),
                    //List Cart
                  ]).py12(),
            ).pSymmetric(h: 16, v: 8).w(context.screenWidth);
        }
        return 0.heightBox;
      }
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, orderState) {
        if (orderState is OrderIsSuccess) {
          Commons().showSnackBar(context, orderState.message);
        }
        if (orderState is OrderIsFailed) {
          Commons().showSnackBar(context, orderState.message);
        }
      },
      child: BlocBuilder<ListCartBloc, ListCartState>(
        builder: (context, state) {
          if (state is ListCartIsSuccess) {
            List tempList = <ProductModel>[];

            double cartSubtotal() {
              double total = 0;
              for (var item in state.data) {
                if (item.variant![0] == item.variant![0]) {
                  tempList.add(item);
                  total += item.price!;
                }
              }
              return total;
            }

            double cartTax() {
              double total = cartSubtotal() * 0.1;
              return total;
            }

            double discount(){
              double total = 0;
              return total;
            }

            double cartTotalPrice() {
              double total = 0;
              total = cartSubtotal() + cartTax() - discount();
              return total;
            }

            return ButtonWidget(
              color: colorName.secondary,
              text: 'Pay',
              textSize: 16,
              isLoading: (state is OrderIsLoading)
                  ? true
                  : false,
              onPressed: () {
                BlocProvider.of<OrderBloc>(context).add(
                    OrderRequest(
                        cartTotalPrice(),
                        (state as ListCartIsSuccess).data
                    ));
              },
            )
                .w(context.screenWidth)
                .h(context.percentHeight*5)
                .pSymmetric(h: 16, v: 8);
          }
          return 0.heightBox;
        },
      )
    );
  }
}
