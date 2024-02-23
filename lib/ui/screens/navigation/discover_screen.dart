import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';
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
        toolbarHeight: 64,
        leading: IconButton(
          padding: EdgeInsets.only(left: 16, top: 15),
          icon: Icon(
            Iconsax.menu_14,
            size: 23,
          ),
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
      body: ListView(
        children: [
          SizedBox(height: 16),
          _buildFollowingStoriesList(context),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).scaffoldBackgroundColor,
          //     boxShadow: [kSubtleShadow],
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(40),
          //       topRight: Radius.circular(40),
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           Text("username1"),
          //         ],
          //       ),
          //     ],
          //   ),
          // )
          for (int i = 0; i < 10; i++)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: PostWidget(
                  username: "username",
                  profilePictureUrl: "https://picsum.photos/80",
                  imageUrl: "https://picsum.photos/400",
                  caption: "Caught in 8k",
                  likes: 12,
                  comments: 11),
            ),
        ],
      ),
    );
  }

  Widget _buildFollowingStoriesList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 16),
          for (int i = 0; i < 9; i++)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ZoomTapAnimation(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: 4, left: 4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 187, 152, 91),
                            Theme.of(context).colorScheme.primary,
                          ],
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        padding: EdgeInsets.all(2),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://picsum.photos/200",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      "username",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
