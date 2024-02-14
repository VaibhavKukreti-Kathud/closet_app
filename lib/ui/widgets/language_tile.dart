import 'package:flutter/material.dart';

class LanguageTile extends StatefulWidget {
  LanguageTile({required this.language});

  final String language;

  @override
  State<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends State<LanguageTile> {
  bool isSelected = false;

  void selectTile() {
    if (isSelected == false) isSelected = true;
    else isSelected = false;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        selectTile();
      },
      child: Material(
        color: isSelected ? Colors.black : Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 16.0),
              child: Text(widget.language,style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w600,color: isSelected ? Colors.white : Colors.black),textAlign: TextAlign.center,),
            ),
            Divider(
              height: 1.0,
              color: isSelected ? Colors.white : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}