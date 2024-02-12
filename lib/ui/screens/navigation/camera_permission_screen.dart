import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

class CameraPermScreen extends StatelessWidget {
  const CameraPermScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hMargin = MediaQuery.of(context).size.width;
    final vMargin = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        title: Text('My Closet App',
          style: TextStyle(
              fontSize: 36.0,
              color: kDarkPrimaryColor,
              fontFamily: 'Philosopher'
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
                  fontWeight: FontWeight.bold,
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
                  image: NetworkImage('https://static.thenounproject.com/png/2024631-200.png'),
                  width: hMargin/2,
                ),
                SizedBox(
                  height: vMargin/20,
                ),
                Text('ALLOW CAMERA USE',style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Philosopher'
                ),
                ),
                SizedBox(
                  height: vMargin/40,
                ),
                Container(
                  width: 3*hMargin/4,
                  child:
                  Text('My Closet App needs permission to access your Camera and Gallery',
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
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