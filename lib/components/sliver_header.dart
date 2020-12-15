import 'package:flutter/material.dart';
import '../models/photo.dart';
import 'pop_button.dart';
import 'hero_image_button.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({
    Key key,
    @required this.color,
    @required this.photo,
  }) : super(key: key);

  final Color color;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: color,
      leading: PopButton(color: color),
      pinned: true,
      expandedHeight: 350,
      stretch: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(  
        stretchModes: [
          StretchMode.zoomBackground,
        ],
        background: HeroImageButton(src: photo.urls.full, color: photo.color, tag: photo.id, blurHash: photo.blurHash,)
      ),
    );
  }
}