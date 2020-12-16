import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/components/pop_button.dart';

class PhotoViewerView extends StatelessWidget {
  const PhotoViewerView({Key key, @required this.src, @required this.tag, @required this.color}) : super(key: key);

  final String src;
  final String tag;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: PopButton(color: HexColor(color), icon: Icons.close,),
      ),
      body: Container(  
        color: HexColor(color), 
        child: PhotoView(   
          loadingBuilder: (context, event) => CircularProgress(color: HexColor(color),),
          imageProvider: NetworkImage(  
            src
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: 0.8,
          backgroundDecoration: BoxDecoration( 
            color: Colors.transparent
          ),
          heroAttributes: PhotoViewHeroAttributes(
            tag: tag, 
            transitionOnUserGestures: true,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}