import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'camera_permission_screen.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LocationPermScreen extends StatelessWidget {
  const LocationPermScreen({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.4;
    final hMargin = MediaQuery.of(context).size.width;
    final vMargin = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        backgroundColor: Colors.white,
        title: Hero(
          tag: 'appname',
          child: Text('My Closet App',
            style: TextStyle(
                fontSize: 36.0,
                color: kDarkPrimaryColor,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                fontFamily: 'Philosopher'
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: Text('Skip',
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImage('https://t4.ftcdn.net/jpg/03/35/85/11/360_F_335851125_Bgb5pSUztCVpEn1BoeIU9Uwytxpm5iJ7.jpg'),
                  width: hMargin/2,
                ),
                SizedBox(
                  height: vMargin/20,
                ),
                Text('ADD YOUR LOCATION',style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Philosopher'
                ),
                ),
                SizedBox(
                  height: vMargin/40,
                ),
                Container(
                  width: 2*hMargin/3,
                  child: Text('Enjoy all benefits of the app by allowing Location Access now',
                    style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.grey.shade800
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPermScreen()));
            },
            child: Container(
              color: kDarkPrimaryColor,
              width: double.infinity,
              height: vMargin/12,
              child: Center(
                  child: Text('ACCEPT',
                    style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w600),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}