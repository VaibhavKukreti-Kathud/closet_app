// import 'package:closet_app/ui/screens/navigation/expanded_story_screen.dart';
// import 'package:flutter/material.dart';
//
// class MyPostsList extends StatelessWidget {
//   const MyPostsList({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//       crossAxisCount: 3,
//       shrinkWrap: true,
//       crossAxisSpacing: 2,
//       mainAxisSpacing: 2,
//       physics: NeverScrollableScrollPhysics(),
//       children: List.generate(13, (index) {
//         return GestureDetector(
//             onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandedStoryScreen(username: 'vklightning', userImageURL: 'https://picsum.photos/300', storyImageURL: 'https://picsum.photos/300', likes: 20, comments: 7)));
//             },
//             child: Image.network("https://picsum.photos/300")
//         );
//       }),
//     );
//   }
// }
