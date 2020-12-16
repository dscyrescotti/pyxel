import 'dart:ui';

import 'package:flutter/material.dart';
import '../utils/darken.dart';

class PopButton extends StatelessWidget {
  const PopButton({
    Key key,
    this.color,
    this.icon = Icons.arrow_back
  }) : super(key: key);

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final _color = color.computeLuminance() < 0.5 ? Colors.white : Colors.black;
    return Tooltip( 
      message: "Back",
      child: FlatButton( 
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: CircleBorder(),
        child: Container(  
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(  
            color: darken(color).withOpacity(0.4),
            shape: BoxShape.circle
          ),
          child: Hero(  
            tag: "hero.back.button",
            flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
              return FadeTransition(  
                opacity: animation, 
                child: RotationTransition(  
                  turns: animation,
                  child: toHeroContext.widget,
                ),
              );
            },
            child: Icon(
              icon,
              size: 25,
              color: _color,
            ),
          ),
        ),
        onPressed: Navigator.of(context).pop,
      ),
    );
  }
}