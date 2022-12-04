part of 'widgets.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final String routeName;
  final Widget child;

  const SectionWidget(
      {super.key,
      required this.title,
      required this.routeName,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HStack([
          title.text.bold.size(16).base.make().expand(),
          ((routeName.isEmpty) ? "" : "See All")
              .text
              .size(12)
              .base
              .make()
              .onTap(() {
            context.go(routeName);
          }),
        ]),
        8.heightBox,
        child,
      ],
      axisSize: MainAxisSize.min,
    );
  }
}
