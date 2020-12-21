import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import '../models/photo.dart';

class TagsRow extends StatelessWidget {
  const TagsRow({
    Key key,
    this.tags,
    this.margin,
    this.padding,
  }) : super(key: key);
  final List<Tag> tags;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: tags.length == 0 ? EdgeInsets.zero : padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [
          Text(
            'Tags',
            style: TextStyle(  
              fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
          Tags(  
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            itemCount: tags.length,
            itemBuilder: (index) => ItemTags(
              pressEnabled: false,
              textStyle: TextStyle(  
                fontSize: Theme.of(context).textTheme.caption.fontSize,
                fontWeight: FontWeight.normal
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              index: index, 
              title: tags[index].title,
              border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.3)),
              elevation: 0,
              textActiveColor: Colors.black,
              activeColor: Colors.grey.withOpacity(0.2),
            ),
          ),
        ],
      )
    );
  }
}