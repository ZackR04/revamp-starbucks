part of '../../screens.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  final TextEditingController productVariantsController =
      TextEditingController();

  void reset() {
    //kita hapus name controller
    productNameController.clear();
    //kita hapus price controller
    productPriceController.clear();
    //
    productDescController.clear();
    productVariantsController.clear();
    //kita hapus state image picker
    BlocProvider.of<ProductPictureCubit>(context).resetImage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        reset();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: colorName.primary,
        appBar: AppBar(
          backgroundColor: colorName.secondary,
          title: 'Tambah Produk'.text.make(),
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
          bloc: BlocProvider.of<AdminBloc>(
              context)..add(AdminFetchListCategory()),
          listener: (context, state) {
            if (state is AdminIsSuccess) {
              reset();
              Commons().showSnackBar(context, state.message);
            } else if (state is AdminIsFailed) {
              Commons().showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            return VStack([
              _buildProductForm(state),
              ButtonWidget(
                onPressed: () {
                  BlocProvider.of<AdminBloc>(context).add(AddProduct(
                    name: productNameController.text,
                    price: double.parse(productPriceController.text),
                    desc: productDescController.text,
                    category: (state as AdminFetchCategory).valDefault,
                    variants: productVariantsController.text,
                  ));
                },
                isLoading: (state is AdminIsLoading) ? true : false,
                text: 'Unggah Produk',
              ).px16()
            ]);
          },
        ),
      ),
    );
  }

  Widget _buildProductForm(AdminState state) {
    return VStack([
      TextFieldWidget(
        controller: productNameController,
        title: 'Nama Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productPriceController,
        title: 'Harga Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productDescController,
        maxLines: 4,
        title: 'Deskripsi Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productVariantsController,
        title: 'Variant Produk',
      ),
      12.heightBox,
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: VStack([
          'Kategori Produk'.text.size(16).color(colorName.black.withOpacity(0.85)).make().pOnly(top: 10, left: 4),
          state is AdminFetchCategory ?
          DropdownButton(
            hint: Text('Kategori'),
            value: state.valDefault,
            items: state.listCategory?.map((value) {
              return DropdownMenuItem(
                  child: Text(value), value: value
              );
            }).toList(),
            onChanged: (hasil) {
              BlocProvider.of<AdminBloc>(
                  context).add(AdminFetchListCategory(selectedCategory: '$hasil'));
            },
          ).px4() : 0.heightBox,
        ])
            .box
            .width(context.screenWidth)
            .color(colorName.white)
            .px8
            .make(),
      ),
      8.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsLoaded && state.files.isNotEmpty) {
            return AspectRatio(
                aspectRatio: 16 / 7,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return (index == state.files.length)
                          ? _buildAddImageButton(context)
                          : _buildImage(
                              context: context,
                              image: File(state.files[index].path),
                              index: index);
                    },
                    separatorBuilder: (context, index) => 16.widthBox,
                    itemCount: state.files.length + 1));
          }
          return _buildAddImageButton(context);
        },
      )
    ]).p16();
  }

  Widget _buildAddImageButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<ProductPictureCubit>(context).getImage();
      },
      icon: const Icon(Icons.add_a_photo_rounded),
    ).box.color(colorName.white.withOpacity(.8)).roundedFull.make();
  }

  Widget _buildImage(
      {required BuildContext context,
      required File image,
      required int index}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ZStack(
        [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.file(
              image,
              fit: BoxFit.cover,
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<ProductPictureCubit>(context).deleteImage(index);
            },
            icon: const Icon(Icons.delete_forever),
          ).box.color(colorName.white.withOpacity(.8)).roundedFull.make(),
        ],
        alignment: Alignment.center,
      ),
    );
  }
}
