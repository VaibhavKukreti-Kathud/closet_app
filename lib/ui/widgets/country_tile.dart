import 'package:flutter/material.dart';

class CountryTile extends StatefulWidget {
  CountryTile({required this.flag,required this.country});

  final String flag;
  final String country;

  @override
  State<CountryTile> createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
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
              padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.flag,style: TextStyle(fontSize: 36.0),),
                  Flexible(
                      child: Text(widget.country,style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w600,color: isSelected ? Colors.white : Colors.black),textAlign: TextAlign.center,)
                  ),
                  Icon(Icons.arrow_forward_ios,size: 18.0,
                      color: isSelected ? Colors.white : Colors.black)
                ],
              ),
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