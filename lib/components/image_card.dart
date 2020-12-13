import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pyxel/models/photo.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key key, this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (photo.height / photo.width * MediaQuery.of(context).size.width * 0.5) - 25,
      child: ClipRRect(  
        borderRadius: BorderRadius.circular(10),
        child: Image.network(  
          photo.urls.small,
          fit: BoxFit.fitWidth,
          width: double.infinity,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedSwitcher( 
              child: frame == null ? BlurHash(hash: photo.blurHash) : child,
              duration: Duration(milliseconds: 350),
            );
          },
        ),
      )
    );
  }
}