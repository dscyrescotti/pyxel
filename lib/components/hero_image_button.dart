import 'package:flutter/material.dart';
import 'package:pyxel/views/photo_viewer_view.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'route_transition.dart';

class HeroImageButton extends StatelessWidget {
  const HeroImageButton({
    Key key,
    this.src,
    this.color,
    this.tag,
    this.blurHash
  }) : super(key: key);
  final String src;
  final String tag;
  final String color;
  final String blurHash;

  @override
  Widget build(BuildContext context) {
    return InkWell(  
      onTap: () {
        Navigator.push(context, FadeRoute(page: PhotoViewerView(src: src, tag: tag, color: color,)));
      },
      child: Hero(  
        tag: tag,
        child: Image.network(  
          src,
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (context, child, event) {
            if (event == null) {
              return child;
            }
            return BlurHash(hash: blurHash);
          },
        ),
      ),
    );
  }
}