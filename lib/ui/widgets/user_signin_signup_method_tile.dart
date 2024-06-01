import 'package:closet_app/constants.dart';
import 'package:flutter/material.dart';

class UserLoginSignupMethodTile extends StatelessWidget {
  UserLoginSignupMethodTile(
      {required this.organisationIcon,
      required this.organisationIconColor,
      required this.organisationName,
      required this.methodName,
      required this.isGoogle});

  final IconData organisationIcon;
  final Color organisationIconColor;
  final String organisationName;
  final String methodName;
  final bool isGoogle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Color(0xffBF9370),
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isGoogle
              ? Image(image: AssetImage('images/google_icon.png'))
              : Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child:
                      Icon(organisationIcon, size: 36.0, color: Colors.white),
                ),
          SizedBox(width: 8),
          Align(
            alignment: Alignment.center,
            child: Text(
              '$methodName with $organisationName',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
