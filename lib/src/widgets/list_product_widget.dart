part of 'widgets.dart';

class ListProductWidget extends StatelessWidget {
  final String? pictures;
  final String? name;
  final double? price;
  final String? id;

  const ListProductWidget({
    super.key,
    this.pictures,
    this.name,
    this.price,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        VxCircle(
            radius: 95,
            backgroundImage: DecorationImage(
                image: NetworkImage(pictures!), fit: BoxFit.cover)
        ),
        12.widthBox,
        VStack([
          name!.text.maxLines(2).size(14).base.bold.make(),
          4.heightBox,
          Commons().setPriceToIDR(price!).text.size(14).make(),
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
                          .removeFromWishList(id!);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: colorName.accentRed,
                    ));
              }
              return IconButton(
                  onPressed: () {
                    // BlocProvider.of<WishlistCubit>(context)
                    //     .addToWishList(state.products);
                  },
                  icon: const Icon(Icons.favorite_border_rounded));
            },
          ),
        )
      ],
    ).box
    .py12
     .make()
        .onTap(() {
          context.go(routeName.detailPath, extra: id);
        });
  }
}
