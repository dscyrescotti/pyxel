import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key key, this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final _color = color == null? Colors.blue : color.computeLuminance() < 0.5 ? Colors.white : Colors.black;
    return Center( 
      child: SizedBox(  
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(_color),),
        height: 25,
        width: 25,
      ),
    );
  }
}