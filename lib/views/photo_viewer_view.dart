import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerView extends StatelessWidget {
  const PhotoViewerView({Key key, @required this.src, @required this.tag, @required this.color}) : super(key: key);

  final String src;
  final String tag;
  final String color;

  @override
  Widget build(BuildContext context) {
    return PhotoView(   
        imageProvider: NetworkImage(  
          src
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: 0.8,
        backgroundDecoration: BoxDecoration( 
          color: HexColor(color)
        ),
        heroAttributes: PhotoViewHeroAttributes(
          tag: tag, 
          transitionOnUserGestures: true,
        ),
    );
  }
}