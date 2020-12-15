import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/view_models/photo_details_view_model.dart';
import 'package:pyxel/components/sliver_header.dart';

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
                SliverHeader(color: color, photo: photo),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(  
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Row( 
                       children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration( 
                            shape: BoxShape.circle,
                            color: color,
                          ),
                          child: ClipOval(
                            child: viewModel.user != null ? Image.network(
                              viewModel.user.profileImage.large
                            ) : null,
                          ),
                          margin: EdgeInsets.only(right: 10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              photo.user.name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              '@${photo.user.username}',
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                         )
                       ],
                     ), 
                    )
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

