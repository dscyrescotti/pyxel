import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pyxel/models/photo.dart';
import 'package:pyxel/views/photo_details_view.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key key, this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      hoverElevation: 10,
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PhotoDetailsView(id: photo.id)));
      },
      padding: EdgeInsets.all(0),
      child: ClipRRect(  
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: (photo.height / photo.width * (MediaQuery.of(context).size.width - 30) * 0.5),
          width: double.infinity,
          color: HexColor(photo.color),
          child: 
          // CachedNetworkImage( 
          //   fit: BoxFit.fitWidth,
          //   width: double.infinity,
          //   imageUrl: photo.urls.small,
          //   placeholder: (context, url) => BlurHash(hash: photo.blurHash),
          //   placeholderFadeInDuration: Duration(milliseconds: 0),
          //   fadeOutDuration: Duration(milliseconds: 0),
          // )
          
          Image.network(  
            photo.urls.small,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedSwitcher( 
                child: frame == null ? BlurHash(hash: photo.blurHash) : child,
                duration: Duration(milliseconds: 200),
              );
            },
          ),
        ),
      )
    );
  }
}