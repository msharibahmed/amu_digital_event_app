import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = 'help-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.mail),
        label: Text('Contact Us'),
        elevation: 5,
      ),
      body: AboutDialog(
        applicationName: 'AMU Digital Event',
        applicationIcon: Image.asset('assets/icons/amulogo.png',width: 50,height: 50,),
        applicationVersion: 'Version: 1.0',
      ),
    );
  }
}
