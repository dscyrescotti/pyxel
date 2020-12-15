import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  SlideRoute({this.page}) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(   
      position: Tween<Offset>(  
        begin: Offset(0, 1),
        end: Offset.zero
      ).animate(animation),
      child: child,
    ),
  );
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page}) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(   
      opacity: Tween<double>(  
        begin: 0.0,
        end: 1.0
      ).animate(animation),
      child: child,
    ),
  );
}