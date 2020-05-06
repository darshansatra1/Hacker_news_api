import 'package:flutter/material.dart';
import 'package:hacker_news/src/routes.dart';
import 'package:hacker_news/src/screen/news_list.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.materialPageRoute,
    );
  }
}
