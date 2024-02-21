import 'package:closet_app/models/cloth_item_model.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
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
  List<WardrobeItem> wardrobeItems = [
    WardrobeItem(
      name: "T-Shirt",
      imageUrl: "https://picsum.photos/200",
      id: '1',
      color: [],
      price: 300,
      uploadedBy: 'user',
    ),
    WardrobeItem(
      name: "Shirt",
      imageUrl: "https://picsum.photos/200",
      id: '2',
      color: [],
      price: 300,
      uploadedBy: 'user',
    ),
    WardrobeItem(
      name: "Jeans",
      imageUrl: "https://picsum.photos/200",
      id: '3',
      color: [],
      price: 300,
      uploadedBy: 'user',
    ),
    WardrobeItem(
      name: "Shoes",
      imageUrl: "https://picsum.photos/200",
      id: '4',
      color: [],
      price: 300,
      uploadedBy: 'user',
    ),
  ];

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
      body: GridView.count(
        crossAxisCount: 2,
        children: wardrobeItems.map((item) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [kSubtleShadow],
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius - 3),
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Text(
                    item.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 12),
                  child: Text(
                    "₹${item.price}",
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
