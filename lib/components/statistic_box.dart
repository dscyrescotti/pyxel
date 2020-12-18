import 'package:flutter/material.dart';

class StatisticBox extends StatelessWidget {
  const StatisticBox({Key key, this.title, this.value}) : super(key: key);

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(  
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Colors.black.withOpacity(0.5))
        ),
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(  
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(  
                fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}