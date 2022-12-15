part of '../../../screens.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      body: BlocBuilder<ListOrderBloc, ListOrderState>(
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
                    (listOrderState.model[index].paymentStatus! == 1
                                ? 'Pembayaran Berhasil'
                        : listOrderState.model[index].paymentStatus! == 2
                        ? 'Pesanan Diproses'
                        : listOrderState.model[index].paymentStatus! == 3
                        ? 'Pesanan Ditolak'
                                : 'Invalid Order')
                        .text
                        .color((listOrderState.model[index].paymentStatus! == 1
                                ? colorName.accentBlue
                        : listOrderState.model[index].paymentStatus! == 2
                        ? colorName.secondary
                        : listOrderState.model[index].paymentStatus! == 3
                        ? colorName.accentRed
                                : colorName.accentRed))
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
                  switch (listOrderState.model[index].paymentStatus!) {
                    case 0:
                      Commons().showSnackBar(context, 'Ke Halaman Pembayaran');
                      break;
                    case 1:
                      Commons().showSnackBar(context, 'Ke Halaman Detail');
                      break;
                    case 2:
                      Commons().showSnackBar(context, 'Ke Halaman Selesai');
                      break;
                    default:
                  }
                });
              },
            );
          }
          return 0.heightBox;
        },
      ),
    );
  }
}
