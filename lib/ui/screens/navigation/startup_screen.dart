import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'location_permission_screen.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hMargin = MediaQuery.of(context).size.width;
    final vMargin = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://t4.ftcdn.net/jpg/04/39/11/37/360_F_439113797_PCCwosDTsst8Tf8Z5QJVIvEIbfKdYZjn.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: hMargin/40,bottom: vMargin/10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(
                  tag: 'appname',
                  child: Text('My Closet App',
                    style: TextStyle(
                        fontSize: 54.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Philosopher'
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text('Adding Moments to Styles',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPermScreen()));
                  },
                  child: Material(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 12.0),
                      child: Text('Let\'s Start',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: kDarkPrimaryColor,
                            fontFamily: 'Philosopher'
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}