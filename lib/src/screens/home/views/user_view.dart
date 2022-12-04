part of '../../screens.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserIsSuccess) {
              return VStack(
                [
                  ZStack(
                    [
                      VxCircle(
                        radius: 120,
                        backgroundImage: (state.data.photoProfile!.isNotEmpty)
                            ? DecorationImage(
                                image: NetworkImage(state.data.photoProfile!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      IconButton(
                        onPressed: () {},
                        color: colorName.white,
                        icon: const Icon(Icons.photo_camera).onTap(() {
                          BlocProvider.of<UserBloc>(context).add(ChangePhoto());
                        }),
                      )
                    ],
                    alignment: Alignment.center,
                  ),
                  16.heightBox,
                  VStack(
                    [
                      state.data.username!.text.size(16).bold.make(),
                      state.data.email!.text.size(12).make(),
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ),
                  BlocBuilder<ListOrderBloc, ListOrderState>(
                    builder: (context, listOrderState) {
                      if (listOrderState is ListOrderIsSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: listOrderState.model.length,
                          itemBuilder: (context, index) {
                            return VStack([
                              HStack([
                                listOrderState.model[index].productName!.text
                                    .make()
                                    .expand(),
                                (listOrderState.model[index].paymentStatus! == 0
                                        ? 'Belum Dibayar'
                                        : listOrderState.model[index]
                                                    .paymentStatus! ==
                                                1
                                            ? 'Pesanan Diproses'
                                            : 'Selesai')
                                    .text
                                    .color((listOrderState
                                                .model[index].paymentStatus! ==
                                            0
                                        ? colorName.accentRed
                                        : listOrderState.model[index]
                                                    .paymentStatus! ==
                                                1
                                            ? colorName.accentBlue
                                            : colorName.accentGreen))
                                    .make()
                              ]),
                              const VxDivider(
                                type: VxDividerType.horizontal,
                              ).py8(),
                              VStack(listOrderState.model[index].products
                                  .map((e) => HStack([
                                        VxBox()
                                            .size(40, 40)
                                            .bgImage(DecorationImage(
                                              image: NetworkImage(
                                                e.pictures![0],
                                              ),
                                              fit: BoxFit.cover,
                                            ))
                                            .roundedSM
                                            .make(),
                                        4.widthBox,
                                        e.name!.text.make(),
                                      ]).py4())
                                  .toList()),
                              16.heightBox,
                              'Total: ${Commons().setPriceToIDR(listOrderState.model[index].totalPrice!)}'
                                  .text
                                  .bold
                                  .make()
                                  .objectBottomRight(),
                            ])
                                .p16()
                                .box
                                .roundedSM
                                .color(colorName.white)
                                .make()
                                .p16()
                                .onTap(() {
                              switch (
                                  listOrderState.model[index].paymentStatus!) {
                                case 0:
                                  //TODO: Belum dibayar
                                  Commons().showSnackBar(
                                      context, 'Ke Halaman Pembayaran');
                                  break;
                                case 1:
                                  //TODO: Diproses
                                  Commons().showSnackBar(
                                      context, 'Ke Halaman Detail');
                                  break;
                                case 2:
                                  //TODO: Selesai
                                  Commons().showSnackBar(
                                      context, 'Ke Halaman Selesai');
                                  break;
                                default:
                              }
                            });
                          },
                        );
                      }
                      return 0.heightBox;
                    },
                  )
                ],
                crossAlignment: CrossAxisAlignment.center,
              ).wFull(context).pSymmetric(v: 12);
            }
            return 0.heightBox;
          },
        ).scrollVertical(),
      ),
    );
  }
}
