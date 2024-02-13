import 'package:flutter/material.dart';
import 'package:closet_app/ui/widgets/country_tile.dart';
import 'package:closet_app/ui/constants/geography_constants.dart';
import 'package:closet_app/ui/screens/authentication/sign_up/select_language_screen.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
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
                  child: Text('Select your Country',
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
                        return CountryTile(flag: flags[index], country: countries[index]);
                      },
                      itemCount: countries.length,
                    )
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectLanguageScreen()));
            },
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: vMargin/12,
              child: Center(
                  child: Text('CONTINUE',
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