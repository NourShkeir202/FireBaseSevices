import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/shared/network/local/cache_helper.dart';

import 'moduels/home.dart';
import 'moduels/login/login.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;

 var uId = CacheHelper.getData(key: 'uId');
 if(uId  !=null)
 {
   widget =HomeScreen();
 }else
   {
     widget = LoginScreen();
   }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key,this.startWidget}) : super(key: key);
final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline2: TextStyle(
            color: Colors.black
          )
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.indigo,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          color: Colors.white,
          elevation: 0
        )
      ),
      home: startWidget
    );
  }
}
