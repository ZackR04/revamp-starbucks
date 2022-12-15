part of '../screens.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      appBar: AppBar(
        backgroundColor: colorName.secondary,
        title: 'Pembayaran'.text.make(),
      ),
      body: VStack([
        _buildNorek().px12(),
        20.heightBox,
        _buildAnimation(context).centered(),
      ]).pSymmetric(v: 20),
      bottomNavigationBar: _buildButtonPay(context),
    );
  }

  Widget _buildNorek() {
    return VStack([
      "Silahkan melakukan pembayaran ke Rekening:".text.size(20).make(),
      12.heightBox,
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: "BRI: 08296359604779 a/n Sujatmiko".text.size(26).color(colorName.white).make()
            .box.color(colorName.secondary).p8.make(),
      ),
      12.heightBox,
      "Atau melakukan pembayaran ke kasir dengan\nmenyebutkan Order ID".text.size(20).make()
    ],
      crossAlignment: CrossAxisAlignment.center,);
  }

  Widget _buildAnimation(BuildContext context) {
    return Lottie.asset('assets/lottie/money_transfer.json');
  }

  Widget _buildButtonPay(BuildContext context) {
    return BlocBuilder<DetailOrderBloc,DetailOrderState>(
        builder: (context, state) {
          if (state is DetailOrderIsSuccess) {
            return VStack([
              VStack([
                HStack([
                  'Order ID'.text.size(20).make().expand(),
                  state.model.id.toString().text.make(),
                ]),
                HStack([
                  'Total Pembayaran'.text.size(20).make().expand(),
                  Commons().setPriceToIDR(state.model.totalPrice!)
                      .text
                      .bold
                      .make()
                ]),
              ]).px4(),
              16.heightBox,
              ButtonWidget(
                color: colorName.secondary,
                text: 'Sudah melakukan pembayaran',
                textSize: 16,
                // isLoading: (state is OrderIsLoading) ? true : false,
                onPressed: () {
                  BlocProvider.of<StatusOrderCubit>(context).changeStatus("${state.model.id}", 1);
                },
              )
                  .w(context.screenWidth)
                  .h(context.percentHeight * 5)

            ]).pSymmetric(h: 16, v: 12).box.color(colorName.white).make();
          }
          return 0.heightBox;
        },
    );
  }

}
