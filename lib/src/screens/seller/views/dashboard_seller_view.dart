part of '../../screens.dart';

class DashboardSellerView extends StatelessWidget {
  const DashboardSellerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserIsLoading) {
              return const CircularProgressIndicator().centered();
            } else if (state is UserIsSuccess) {
              return VStack(
                [
                  _buildAppBar(context, state.data),
                  24.heightBox,
                  _buildListProduct(context).expand(),
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
            }
            return 0.heightBox;
          },
        ).p16().centered(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack([
        VxCircle(
          radius: 56,
          backgroundImage: (data.photoProfile!.isNotEmpty)
              ? DecorationImage(
            image: NetworkImage(data.photoProfile!),
            fit: BoxFit.cover,
          )
              : null,
        ).onTap(() {
          context.go(routeName.adminPath);
        }),
        16.widthBox,
        data.username!.text.size(20).bold.make(),
      ]),
    ).make();
  }

  Widget _buildListProduct(BuildContext context) {
    return BlocConsumer<ListProductBloc, ListProductState>(
      bloc: BlocProvider.of<ListProductBloc>(context)..add(FetchListProduct()),
      listener: (context, state) {
        if (state is ListProductIsFailed) {
          Commons().showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ListProductIsLoading) {
          //Loading Widget
          return const CircularProgressIndicator().centered();
        }
        if (state is ListProductIsSuccess) {
          //List Product Widget
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5 / 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return _buildProductWidget(context, state.products[index]);
            },
          );
        }
        return 0.heightBox;
      },
    );
  }

  Widget _buildProductWidget(BuildContext context, ProductModel data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: VStack(
        [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.network(
              data.pictures![0],
              fit: BoxFit.cover,
            ),
          ),
          VStack([
            data.name!.text.size(16).bold.make(),
            4.heightBox,
            Commons().setPriceToIDR(data.price!).text.size(12).make(),
          ]).p8()
        ],
      ).box.white.make(),
    ).onTap(() {
      context.go(routeName.editPath, extra: data.id);
    });
  }
}
