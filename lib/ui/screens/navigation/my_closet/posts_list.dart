import 'package:closet_app/ui/screens/navigation/widget/post_widget.dart';
import 'package:flutter/material.dart';

class MyPostsList extends StatelessWidget {
  const MyPostsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(13, (index) {
        return Image.network("https://picsum.photos/300");
      }),
    );
  }
}
