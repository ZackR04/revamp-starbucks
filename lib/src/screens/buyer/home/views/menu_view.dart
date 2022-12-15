// ignore_for_file: prefer_const_constructors

part of '../../../screens.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.percentHeight * 20),
        child: _buildSearchBar(context),
      ),
      body: VStack([
        _buildCategory(),
        // _buildListMenu(),
        _buildCoffee(),
        _buildNonCoffee(),
        _buildMakanan(),
        _buildLainlain(),
      ]).scrollVertical(),
    );
  }

  // Widget _buildAppBar() {
  //   return HStack([
  //     'Menu'.text.makeCentered()
  //   ]);
  // }

  Widget _buildSearchBar(BuildContext context) {
    return TextFormField(
      controller: searchController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      cursorColor: colorName.secondary,
      decoration: InputDecoration(
        hintText: 'Cari Minuman?',
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.percentWidth * 10)),
      ),
    ).pSymmetric(h: 12).pOnly(top: 40, bottom: 8);
  }

  Widget _buildCategory() {
    return BlocBuilder<AdminBloc, AdminState>(
      bloc: BlocProvider.of<AdminBloc>(context)..add(AdminFetchListCategory()),
      builder: (context, state) {
        if (state is AdminFetchCategory) {
          //List Product Widget
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.listCategory!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: state.listCategory![index]
                      .toString()
                      .text
                      .color(colorName.white)
                      .size(16)
                      .makeCentered()
                      .px16()
                      .box
                      .color(colorName.secondary)
                      .make(),
                ).px4(),
              );
              //_buildProductWidget(context, state.products[index]);
            },
          ).h(context.percentHeight * 4).pSymmetric(h: 12, v: 4);
        }
        return 0.heightBox;
      },
    );
  }

  Widget _buildListMenu() {
    return VStack([
      'Minuman'.text.bold.size(16).base.make().px8(),
      BlocConsumer<ListProductBloc, ListProductState>(
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

            return VStack([
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ListProductWidget(
                    pictures: state.products[index].pictures?.first,
                    name: state.products[index].name,
                    price: state.products[index].price,
                    id: state.products[index].id,
                  );
                  //_buildProductWidget(context, state.products[index]);
                },
              ),
            ]);
          }
          return 0.heightBox;
        },
      ),
    ]).pSymmetric(h: 16, v: 10);
  }

  Widget _buildCoffee() {
    return VStack([
      'Coffee'.text.bold.size(18).base.make().pSymmetric(h: 8, v: 4),
      BlocConsumer<ListProductBloc, ListProductState>(
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
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  )
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ]).pSymmetric(h: 16, v: 10);
  }

  Widget _buildNonCoffee() {
    return VStack([
      'Non-Coffee'.text.bold.size(18).base.make().pSymmetric(h: 8, v: 4),
      BlocConsumer<ListProductBloc, ListProductState>(
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
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  )
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ]).pSymmetric(h: 16, v: 10);
  }

  Widget _buildMakanan() {
    return VStack([
      'Makanan'.text.bold.size(18).base.make().pSymmetric(h: 8, v: 4),
      BlocConsumer<ListProductBloc, ListProductState>(
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
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  )
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ]).pSymmetric(h: 16, v: 10);
  }

  Widget _buildLainlain() {
    return VStack([
      'Lain-lain'.text.bold.size(18).base.make().pSymmetric(h: 8, v: 4),
      BlocConsumer<ListProductBloc, ListProductState>(
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
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListProductWidget(
                        pictures: data[index].pictures?.first,
                        name: data[index].name,
                        price: data[index].price,
                        id: data[index].id,
                      );
                      //_buildProductWidget(context, state.products[index]);
                    },
                  )
                : 0.heightBox;
          }
          return 0.heightBox;
        },
      ),
    ]).pSymmetric(h: 16, v: 10);
  }
}
