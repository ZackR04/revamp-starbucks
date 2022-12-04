part of 'widgets.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double textSize;
  final Color? colorText;
  final Color? color;
  final bool? isLoading;
  const ButtonWidget(
      {super.key,
      this.onPressed,
      this.text = 'Button',
      this.textSize = 14,
      this.colorText = colorName.white,
      this.color = colorName.secondary,
      this.isLoading = false,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading! ? null : onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: isLoading!
          ? SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ).centered()
          : text.text.buttonText(context).size(textSize).color(colorText).make(),
    );
  }
}
