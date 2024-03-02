import 'package:flutter/material.dart';
import 'package:closet_app/ui/constants/terms_and_condition_constants.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {

  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    final hMargin = MediaQuery.of(context).size.width;
    final vMargin = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: Text('Terms and Conditions',style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Philosopher'
        ),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTermsAndConditionsContent(),
                SizedBox(height: 10.0,),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _termsAccepted = !_termsAccepted;
                          });
                        },
                        child: Text(
                          'I have read all the terms and conditions carefully and hereby accept them.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: (){
                    _termsAccepted ? print('Aage Badhega') : null;
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
          )
      ),
    );
  }

  Widget _buildTermsAndConditionsContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Before proceeding further, kindly go through our Terms and Conditions carefully and accept them to begin your Fashion journey !',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Text(
            termsAndConditions,
            // Adjust the range to display the appropriate portion of the terms
            style: TextStyle(fontSize: 16.0),
            overflow: TextOverflow.fade, // Handling overflow
          ),
        ],
      ),
    );
  }
}