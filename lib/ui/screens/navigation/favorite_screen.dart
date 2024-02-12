import 'package:closet_app/models/cloth_item_model.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<WardrobeItem> wardrobeItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 40,
        toolbarHeight: 86,
        centerTitle: false,
        title: 'Favorites',
        actionIcon: Iconsax.sort,
        onActionPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    RadioListTile(
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {},
                      title: Text('Sort by Date'),
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: 1,
                      onChanged: (value) {},
                      title: Text('Sort by Name'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
