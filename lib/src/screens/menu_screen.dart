// ignore_for_file: prefer_const_constructors

part of 'screens.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      body: SafeArea(
        child: VStack([
          4.heightBox,
          _buildSearchBar(context),
          _buildListMenu(),
        ]),
      ),
    );
  }

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
              borderRadius: BorderRadius.circular(context.percentWidth * 10))),
    ).pSymmetric(h: 12, v: 8);
  }

  Widget _buildListMenu() {
    return VStack([
      'Minuman'.text.bold.size(20).base.make().px8(),
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

            return ListView.builder(
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
            );
          }
          return 0.heightBox;
        },
      ),
    ]).pSymmetric(h: 16, v: 10);
  }
}
