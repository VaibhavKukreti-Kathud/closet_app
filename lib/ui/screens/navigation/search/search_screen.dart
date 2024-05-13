import 'package:closet_app/models/cloth_item_model.dart';
import 'package:closet_app/ui/widgets/wardrobe_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List results = [];

  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Iconsax.arrow_left_2),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Search',
            style: TextStyle(color: currTheme.textTheme.titleLarge!.color),
          ),
        ),
        body: Column(
          children: [
            //Search bar
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: currTheme.iconTheme.color!.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search for items',
                    prefixIcon: Icon(
                      Iconsax.search_normal,
                      color: currTheme.iconTheme.color,
                    ),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: currTheme.textTheme.bodyMedium!.color)),
                onChanged: (value) {},
                onSubmitted: (value) {},
              ),
            ),
            //Search results
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  WardrobeItem wardrobeItem =
                      WardrobeItem.fromMap(results[index].data());
                  return WardrobeItemTile(
                      onFavoritePressed: () {}, wardrobeItem: wardrobeItem);
                },
              ),
            ),
          ],
        ));
  }
}
