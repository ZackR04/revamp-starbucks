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
      body: 'Help & Support'.text.makeCentered(),
    );
  }
}
