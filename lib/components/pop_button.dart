import 'dart:ui';

import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  const PopButton({
    Key key,
    this.color
  }) : super(key: key);

  final Color color;

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
          decoration: BoxDecoration(  
            color: color.withOpacity(0.5),
            shape: BoxShape.circle
          ),
          child: Icon(
            Icons.chevron_left,
            size: 35,
            color: _color,
          ),
        ),
        onPressed: Navigator.of(context).pop,
      ),
    );
  }
}