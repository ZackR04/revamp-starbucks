part of '../screens.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.primary,
      appBar: AppBar(
        backgroundColor: colorName.secondary,
        title: 'About Us'.text.make(),
        centerTitle: true,
      ),
      body: 'About Us'.text.makeCentered(),
    );
  }
}
