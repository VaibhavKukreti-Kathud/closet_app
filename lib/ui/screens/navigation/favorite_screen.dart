import 'package:closet_app/models/cloth_item_model.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/expanded_story_screen.dart';
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
    var currTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: currTheme.iconTheme,
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        title: Text('Favorites',
        style: TextStyle(
          fontSize: 30.0,
          color: currTheme.textTheme.titleLarge!.color
        ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    constraints: BoxConstraints(maxHeight: MediaQuery
                        .of(context)
                        .size
                        .height / 2.5),
                    context: context,
                    builder: (context) {
                      return Container(
                        color: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: Text(
                                "Sort",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: currTheme.textTheme.bodyMedium!.color?.withOpacity(0.9),
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            RadioListTile(
                              value: 1,
                              groupValue: 1,
                              onChanged: (value) {},
                              title: Text('By Date',
                              style: TextStyle(color: currTheme.textTheme.bodyMedium!.color),
                              ),
                            ),
                            RadioListTile(
                              value: 2,
                              groupValue: 1,
                              onChanged: (value) {},
                              title: Text('By Name',
                                style: TextStyle(color: currTheme.textTheme.bodyMedium!.color),
                              ),
                            ),
                            RadioListTile(
                              value: 3,
                              groupValue: 1,
                              onChanged: (value) {},
                              title: Text('By Price',
                                style: TextStyle(color: currTheme.textTheme.bodyMedium!.color),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Icon(Iconsax.sort)
              ),
            ),
        ],
      ),
      // appBar: CustomAppBar(
      //   surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      //   elevation: 40,
      //   toolbarHeight: 86,
      //   centerTitle: false,
      //   title: 'Favorites',
      //   actionIcon: Iconsax.sort,
      //   onActionPressed: () {
      //     showModalBottomSheet(
      //       constraints: BoxConstraints(
      //           maxHeight: MediaQuery.of(context).size.height / 2.5),
      //       context: context,
      //       builder: (context) {
      //         return Container(
      //           color: Theme.of(context).scaffoldBackgroundColor,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               SizedBox(height: 16),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 16),
      //                 child: Text(
      //                   "Sort",
      //                   style: getTitleTextStyle(context),
      //                 ),
      //               ),
      //               SizedBox(height: 2),
      //               RadioListTile(
      //                 value: 1,
      //                 groupValue: 1,
      //                 onChanged: (value) {},
      //                 title: Text('By Date'),
      //               ),
      //               RadioListTile(
      //                 value: 2,
      //                 groupValue: 1,
      //                 onChanged: (value) {},
      //                 title: Text('By Name'),
      //               ),
      //               RadioListTile(
      //                 value: 3,
      //                 groupValue: 1,
      //                 onChanged: (value) {},
      //                 title: Text('By Price'),
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      body: GridView.count(
        crossAxisCount: 2,
        children: wardrobeItems.map((item) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandedStoryScreen(username: 'vkukreti07', userImageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5PkW4fJsvhTn3s9hnv2nSU7a5jkGYsUH9Zl7YOHZKeA&s', storyImageURL: item.imageUrl, likes: 10, comments: 5)));
            },
            child: Container(
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
            ),
          );
        }).toList(),
      ),
    );
  }
}
