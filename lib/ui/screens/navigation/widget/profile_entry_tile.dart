import 'package:flutter/material.dart';

class ProfileEntryTile extends StatefulWidget {

  ProfileEntryTile({required this.heading,required this.value});

  final String heading;
  final String value;

  @override
  State<ProfileEntryTile> createState() => _ProfileEntryTileState();
}

class _ProfileEntryTileState extends State<ProfileEntryTile> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.heading,style: TextStyle(color: currTheme.textTheme.bodyMedium!.color,fontSize: 15.0),),
        SizedBox(
          height: 6.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
                  widget.value,
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                )
            ),
            GestureDetector(
              onTap: (){

              },
              child: Icon(Icons.edit_outlined),
            )
          ],
        ),
        Divider(),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}