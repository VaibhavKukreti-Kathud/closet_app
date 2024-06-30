import 'package:closet_app/constants.dart';
import 'package:closet_app/models/cloth_item_model.dart';
import 'package:closet_app/models/post_model.dart';
import 'package:closet_app/services/favorites/favorites_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/post/full_post_screen.dart';
import 'package:closet_app/ui/widgets/main_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesProvider>().getFavorites();

    var currTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: currTheme.iconTheme,
        backgroundColor: currTheme.appBarTheme.backgroundColor,
        title: Text(
          'Favorites',
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2.5),
                    context: context,
                    builder: (context) {
                      return Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Sort",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: currTheme.textTheme.bodyMedium!.color
                                      ?.withOpacity(0.9),
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            RadioListTile(
                              value: 1,
                              groupValue: 1,
                              onChanged: (value) {},
                              title: Text(
                                'By Date',
                                style: TextStyle(
                                    color:
                                        currTheme.textTheme.bodyMedium!.color),
                              ),
                            ),
                            RadioListTile(
                              value: 2,
                              groupValue: 1,
                              onChanged: (value) {},
                              title: Text(
                                'By Name',
                                style: TextStyle(
                                    color:
                                        currTheme.textTheme.bodyMedium!.color),
                              ),
                            ),
                            RadioListTile(
                              value: 3,
                              groupValue: 1,
                              onChanged: (value) {},
                              title: Text(
                                'By Price',
                                style: TextStyle(
                                    color:
                                        currTheme.textTheme.bodyMedium!.color),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Icon(Iconsax.sort)),
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Discovery',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: kSeperatorColor),
                        elevation: 0,
                        backgroundColor: kPrimaryColor),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Groups',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: 7,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image:
                                    NetworkImage('https://picsum.photos/200'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Icon(Icons.bookmark_border),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '@amandachrisperry',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text('Size - '),
                        Text('12',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(' XXS',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
