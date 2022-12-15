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
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: Image.network('$pictures!', fit: BoxFit.cover)
        ).w(context.percentWidth*40).h(context.percentHeight*12),
        12.widthBox,
        VStack([
          name!.text.maxLines(2).size(14).base.bold.make(),
          4.heightBox,
          Commons().setPriceToIDR(price!).text.size(14).make(),
        ])
      ],
    ).box
    .py12
     .make()
        .onTap(() {
          context.go(routeName.detailPath, extra: id);
        });
  }
}
