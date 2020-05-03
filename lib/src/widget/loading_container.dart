import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: ListTile(
        title: greyTile(),
        subtitle: greyTile(),
      ),
    );
  }

  Widget greyTile() {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: Color(0xFFd9b3ff),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.only(top: 5, left: 10, bottom: 5),
    );
  }
}
