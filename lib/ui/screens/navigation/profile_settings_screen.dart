import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_options_screen.dart';
import 'package:closet_app/ui/screens/navigation/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/profile_entry_tile.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => Scaffold(
        backgroundColor: currTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: currTheme.appBarTheme.backgroundColor,
          title: Text('My Profile',
            style: TextStyle(
                fontFamily: 'Philosopher',
                fontSize: 40.0,
                color: currTheme.textTheme.titleLarge!.color
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Switch(
              value: currTheme.brightness == Brightness.dark,
              onChanged: (bool value) {
                value ? theme.setDarkMode() : theme.setLightMode();
              },
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInOptionsScreen()));
                },
                child: Icon(Icons.power_settings_new,
                  color: Colors.red,size: 28.0,
                ),
              ),
            ),
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0,left: 12.0,right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'),
                radius: 54.0,
              ),
              SizedBox(height: 16.0,),
              Text('eashan@02',style: TextStyle(fontSize: 20.0,color: currTheme.textTheme.bodyMedium!.color),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('100 Followers | 80 Following',style: TextStyle(fontSize: 17.0,color: currTheme.textTheme.bodyMedium!.color),)
                ],
              ),
              SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: (){

                      },
                      child: Container(
                          width: 150.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black)
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.male,color: Colors.white,size: 24.0,),
                                  SizedBox(width: 8.0,),
                                  Text('Male',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0
                                    ),
                                  ),
                                ],
                              )
                          )
                      )
                  ),
                  TextButton(
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: (){},
                      child: Container(
                          width: 150.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black)
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.female,color: Colors.black,size: 24.0,),
                                  SizedBox(width: 8.0,),
                                  Text('Female',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0
                                    ),
                                  ),
                                ],
                              )
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 16.0,),
              Expanded(
                child: ListView(
                  children: [
                    ProfileEntryTile(heading: 'Name', value: 'Eashan Bhardwaj'),
                    ProfileEntryTile(heading: 'Email', value: 'eashanbhardwaj02@gmail.com'),
                    ProfileEntryTile(heading: 'DOB', value: '02/09/2003'),
                    ProfileEntryTile(heading: 'Mobile No.', value: '(+91) 7683043484'),
                    ProfileEntryTile(heading: 'Address', value: ('This is my address ' * 4)),
                    ProfileEntryTile(heading: 'Country', value: 'United States (USA)'),
                    ProfileEntryTile(heading: 'Language', value: 'English'),
                    ProfileEntryTile(heading: 'Account Type', value: 'Public'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}