import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/view_models/photo_details_view_model.dart';
import 'package:pyxel/views/photo_viewer_view.dart';
import '../components/pop_button.dart';

class PhotoDetailsView extends StatelessWidget {
  const PhotoDetailsView({Key key, this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhotoDetailsViewModel(id: id),
      child: _PhotoDetailsView(),
    );
  }
}

class _PhotoDetailsView extends StatefulWidget {
  _PhotoDetailsView({Key key}) : super(key: key);

  @override
  __PhotoDetailsViewState createState() => __PhotoDetailsViewState();
}

class __PhotoDetailsViewState extends State<_PhotoDetailsView> {
  @override
  void initState() {
    super.initState();
    Provider.of<PhotoDetailsViewModel>(context, listen: false).fetchPhoto();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PhotoDetailsViewModel>(context);
    return Scaffold( 
      body: Builder(  
        builder: (context) {
          if (viewModel.photo == null) {
            return CircularProgress();
          } else {
            final photo = viewModel.photo;
            final Color color = HexColor(photo.color);
            return CustomScrollView(  
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  backgroundColor: color,
                  leading: PopButton(color: color),
                  pinned: true,
                  expandedHeight: 300,
                  stretch: true,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(  
                    stretchModes: [
                      StretchMode.zoomBackground,
                    ],
                    background: InkWell(  
                      onTap: () {
                        Navigator.of(context).push( 
                          MaterialPageRoute(builder: (context) => PhotoViewerView(src: photo.urls.full, tag: photo.id, color: photo.color))
                        );
                      },
                      child: Hero(  
                        tag: photo.id,
                        child: Image.network(  
                          photo.urls.full,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, event) {
                            if (event == null) {
                              return child;
                            }
                            return BlurHash(hash: photo.blurHash);
                          },
                        ),
                      ),
                    )
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(height: 500),
                    Text(photo.id)
                  ]),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}