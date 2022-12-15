part of '../screens.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController productIDController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  final TextEditingController productVariantsController = TextEditingController();
  final List<String> listImageExisting = <String>[];

  void reset() {
    productNameController.clear();
    productPriceController.clear();
    productDescController.clear();
    productVariantsController.clear();
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
          title: 'Update Produk'.text.make(),
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
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
                  print('Name : ${productNameController.text}');
                  print('Price : ${productPriceController.text}');
                  print('Desc : ${productDescController.text}');
                  print('Variant : ${productVariantsController.text}');
                  print('Collection : $productCollectionName');
                  print('ID Collection : ${productIDController.text}');

                  // BlocProvider.of<AdminBloc>(context).add(AddProduct(
                  //   name: productNameController.text,
                  //   price: double.parse(productPriceController.text),
                  //   desc: productDescController.text,
                  //   category: (state as AdminFetchCategory).valDefault,
                  //   variants: productVariantsController.text,
                  // ));
                },
                isLoading: (state is AdminIsLoading) ? true : false,
                text: 'Update Produk',
              ).px16()
            ]).scrollVertical();
          },
        ),
      ),
    );
  }

  Widget _buildProductForm(AdminState state) {
    if(state is AdminFetchProductByIDSuceess){
      productIDController.text = state.data.id ?? '';
      productNameController.text = state.data.name ?? '';
      productPriceController.text = '${state.data.price}' ?? '';
      productDescController.text = state.data.desc ?? '';
      productVariantsController.text = state.data.variant?.first ?? '';
      if(state.data.pictures != null){
        for(int i=0; i<state.data.pictures!.length; i++){
          listImageExisting.add(state.data.pictures![i]);
        }
      }
      BlocProvider.of<AdminBloc>(context)..add(AdminFetchListCategory(selectedCategory: state.data.category));
    }

    return VStack([
      TextFieldWidget(
        controller: productNameController,
        title: 'Harga Produk',
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
      BlocBuilder<AdminBloc, AdminState>(
        builder: (context, stateCategory){
          if(stateCategory is AdminFetchCategory){
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: VStack([
                'Kategori Produk'.text.size(16).color(colorName.black.withOpacity(0.85)).make().pOnly(top: 10, left: 4),
                state is AdminFetchCategory ?
                DropdownButton(
                  hint: Text('Kategori'),
                  value: stateCategory.valDefault,
                  items: stateCategory.listCategory?.map((value) {
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
            );
          }
          return 0.heightBox;
        },
      ),
      8.heightBox,
      'Current image'.text.size(16).color(colorName.black.withOpacity(0.85)).make().pOnly(top: 10, left: 4, bottom: 8),
      AspectRatio(
          aspectRatio: 16 / 7,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildImageNetwork(
                    context: context,
                    image: Image.network(listImageExisting[index], fit: BoxFit.cover,),
                    index: index);
              },
              separatorBuilder: (context, index) => 16.widthBox,
              itemCount: listImageExisting.length)),
      8.heightBox,
      'Add new image'.text.size(16).color(colorName.black.withOpacity(0.85)).make().pOnly(top: 10, left: 4, bottom: 8),
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
      ),
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

  Widget _buildImageNetwork(
      {required BuildContext context,
        required Image image,
        required int index}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ZStack(
        [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: image,
          ),
          IconButton(
            onPressed: () {
              _deleteImageOnSercer(index);
            },
            icon: const Icon(Icons.delete_forever),
          ).box.color(colorName.white.withOpacity(.8)).roundedFull.make(),
        ],
        alignment: Alignment.center,
      ),
    );
  }

  void _deleteImageOnSercer(int index) {
    BlocProvider.of<ProductPictureCubit>(context).deleteImageOnServer(index);
  }
}

