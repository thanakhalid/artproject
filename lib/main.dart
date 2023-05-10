import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project2/colorsmodelquiz.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white60, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
      ),
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
              image: AssetImage("images/colors.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Card(
              color: Colors.white60,
              margin: EdgeInsets.all(10),
              child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                    child: Text(
                  'colors festival',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
            ElevatedButton(
              child: const Text('colors models quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Colorsmodel()),
                );
              },
            ),
//             FloatingActionButton(onPressed: ()async{
//               dynamic conversationObject = {
// 'appId': '1b4c7e326e24cfc6d064b6a6c07a881d0',// The APP_ID obtained from kommunicate dashboard.
// };
// KommunicateFlutterPlugin.buildConversation(conversationObject) .then((clientConversationId) { print("Conversation builder success : " + clientConversationId.toString()); }).catchError((error) { print("Conversation builder error : " + error.toString()); });
//             },
//             tooltip: 'Increament',
//             child: Icon(Icons.add),
//             )
          ],
        ),
      ),
    ));
  }
}

