import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project2/chatbot.dart';
import 'package:project2/colorsmodelquiz.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white10, // background (button) color
              foregroundColor: Colors.white, // foreground (text) color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              side: BorderSide(color: Colors.white)
            ),
          ),
          fontFamily: 'Raleway'),
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/gback.gif"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
                    'colors festival',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                    ),
                  )
            ),
            SizedBox(height: 100,),
            ElevatedButton(
              child: const Text('colors models quiz', style: TextStyle(fontSize: 35.0),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Colorsmodel()),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: const Text('chatbot', style: TextStyle(
                fontSize: 35.0,
              ),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => chatbot()),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
