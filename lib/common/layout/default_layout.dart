import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar(BuildContext context){
    if (title == null){
      return null;
    }else{

      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(CupertinoIcons.chevron_back),
        //   onPressed: (){
        //     Navigator.pop(context);
        //   },
        // ),
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500
          ),
        ),

        foregroundColor: Colors.black,
      );
    }
  }
}


