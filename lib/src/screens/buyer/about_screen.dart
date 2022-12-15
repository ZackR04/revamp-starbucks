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
      body:
          'The Coffe adalah aplikasi gratis yang khusus dibuat untuk membantu pengusaha warung kopi yang belum memiliki sistem pemesanan kopi secara digital, dengan aplikasi the coffe diharapkan memudahkan para pelaku bisnis warung kopi dalam menerima orderan dan lebih menghemat budget karena semua pemesanan dapat dilakukan dengan paperless.'
              .text
              .xl
              .semiBold
              .justify
              .makeCentered()
              .p16(),
    );
  }
}
