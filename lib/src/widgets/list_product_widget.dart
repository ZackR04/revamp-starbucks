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
    return VStack(
      [
        VxCircle(
            radius: 100,
            backgroundImage: DecorationImage(
                image: NetworkImage(pictures!), fit: BoxFit.cover)
            // child: AspectRatio(
            //   aspectRatio: 16 / 10,

            // ),
            ),
        4.heightBox,
        name!.text.maxLines(2).size(8).base.align(TextAlign.center).make(),
        // VStack([
        //   name!.text.size(16).bold.makeCentered(),
        //   4.heightBox,
        //   Commons().setPriceToIDR(price!).text.size(12).make(),
        // ])
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).box.make().onTap(() {
      context.go(routeName.detailPath, extra: id);
    });
  }
}
