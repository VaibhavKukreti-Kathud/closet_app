import 'package:closet_app/ui/screens/search/search_screen.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 40,
        toolbarHeight: 86,
        leading: IconButton(
          padding: EdgeInsets.only(left: 16, top: 15),
          icon: Icon(Iconsax.menu_14),
          splashColor: Colors.transparent,
          onPressed: () {
            widget.scaffoldKey!.currentState!.openDrawer();
          },
        ),
        centerTitle: false,
        title: 'Discover',
        actionIcon: Iconsax.search_normal,
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SearchScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
