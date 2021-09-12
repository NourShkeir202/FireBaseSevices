import 'package:flutter/material.dart';
import 'package:untitled3/moduels/login/login.dart';
import 'package:untitled3/shared/components/components.dart';
import 'package:untitled3/shared/network/local/cache_helper.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("logout"),
          onPressed: ()
          {
            CacheHelper.removeData('uId');
            navigateAndFinish(context, LoginScreen());
          },
        ),
      ),
    );
  }
}
