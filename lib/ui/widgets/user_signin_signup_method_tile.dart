import 'package:flutter/material.dart';

class UserLoginSignupMethodTile extends StatelessWidget {

  UserLoginSignupMethodTile({required this.organisationIcon,required this.organisationIconColor, required this.organisationName,required this.methodName,required this.isGoogle});

  final IconData organisationIcon;
  final Color organisationIconColor;
  final String organisationName;
  final String methodName;
  final bool isGoogle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ShapeBorder.lerp(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)), ContinuousRectangleBorder(), 0.0),
      color: Colors.grey.shade100,
      child: ListTile(
        leading: isGoogle ?
        Image(image: AssetImage('images/google_icon.png')) :
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Icon(
              organisationIcon,
              size: 36.0,
              color: organisationIconColor
          ),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text('$methodName with $organisationName',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
        ),
        titleAlignment: ListTileTitleAlignment.center,
      ),
    );
  }
}