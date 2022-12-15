part of '../screens.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      appBar: AppBar(
        backgroundColor: colorName.secondary,
        title: 'Help & Support'.text.make(),
        centerTitle: true,
      ),
      body:
          'For More Information and Help please sent your quetion to support@thecoffee.id or topawijaya03@gmail.com, zakiahrezekislubis@gmail.com & vram3012@gmail.com'
              .text
              .center
              .bold
              .xl
              .makeCentered()
              .p16(),
    );
  }
}
