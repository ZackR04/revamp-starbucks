part of 'screens.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(
            child: VStack([
              4.heightBox,
              _buildSearchBar(context),
              'Menu Screen'.text.makeCentered()
            ]),
          ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextFormField(
      controller: searchController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Cari Minuman?',
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.percentWidth*10)
        )
      ),
    ).pSymmetric(h: 12, v: 8);
  }
}
