import 'package:flutter/material.dart';
import 'package:wanderlust/theme/theme.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: Text(
            "Detay",
            style: TextStyle(color: textColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(child: Text("Detay Page")),
        ),
      ),
    );
  }
}
