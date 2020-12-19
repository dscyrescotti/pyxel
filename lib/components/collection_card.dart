import 'package:flutter/material.dart';
import 'package:pyxel/models/collection.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({Key key, this.collection}) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      hoverElevation: 10,
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () {
        // Navigator.push(context, SlideRoute(page: ));
      },
      padding: EdgeInsets.all(0),
      child: ClipRRect(  
        borderRadius: BorderRadius.circular(10),
        child: Builder(  
          builder: (context) {
            if (collection.coverPhoto == null) {
              return Container(
                height: 200,
                color: Colors.red,
              );
            } else {
              final photo = collection.coverPhoto;
              return Container(
                height: 200,
                width: double.infinity,
                color: HexColor(photo.color),
                child: Image.network(  
                  photo.urls.small,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedSwitcher( 
                      child: frame == null ? BlurHash(hash: photo.blurHash ?? "", color: HexColor(photo.color),) : child,
                      duration: Duration(milliseconds: 200),
                    );
                  },
                ),
              );
            }
          },
        )
      ),
    );
  }
}