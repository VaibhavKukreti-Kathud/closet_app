import 'package:closet_app/ui/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/ui/widgets/language_tile.dart';
import 'package:closet_app/ui/constants/geography_constants.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final hMargin = MediaQuery.of(context).size.width;
    final vMargin = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: vMargin/10),
                Container(
                  width: 2*hMargin/3,
                  child: Text('Select your Language',
                    style: TextStyle(
                        fontSize: 56.0,
                        fontFamily: 'Philosopher'
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return LanguageTile(language: languages[index]);
                      },
                      itemCount: languages.length,
                    )
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: vMargin/12,
              child: Center(
                  child: Text('DONE',
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