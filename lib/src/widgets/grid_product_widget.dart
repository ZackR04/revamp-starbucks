part of 'widgets.dart';

class GridProductWidget extends StatelessWidget {
  final String? pictures;
  final String? name;
  final double? price;
  final String? id;

  const GridProductWidget({
    super.key,
    this.pictures,
    this.name,
    this.price,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network('$pictures!', fit: BoxFit.cover))
            .w(context.percentWidth * 40)
            .h(context.percentHeight * 12),
        4.heightBox,
        name!.text.maxLines(2).size(8).base.align(TextAlign.center).make(),
        // VStack([
        //   name!.text.size(16).bold.makeCentered(),
        //   4.heightBox,
        //   Commons().setPriceToIDR(price!).text.size(12).make(),
        // ])
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).box.make().px2().onTap(() {
      context.go(routeName.detailPath, extra: id);
    });
  }
}
