import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/image_card.dart';
import 'package:pyxel/view_models/photos_view_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PhotosView extends StatefulWidget {
  PhotosView({Key key}) : super(key: key);

  @override
  _PhotosViewState createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    Provider.of<PhotosViewModel>(context, listen: false).fetchPhotos();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PhotosViewModel>(context);
    return Scaffold(
      appBar: AppBar(  
        title: Text("pyxel"),
        centerTitle: true,
      ),
      body: viewModel.photos.length == 0 ? Center( 
        child: SizedBox(  
          child: CircularProgressIndicator(),
          height: 30,
          width: 30,
        ),
      ) : RefreshIndicator(
        child: Scrollbar(  
          child: AnimationLimiter(  
            child: StaggeredGridView.countBuilder(
              primary: false,
              crossAxisCount: 4, 
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.all(10),
              physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              controller: _controller,
              itemCount: viewModel.photos.length + 1,
              itemBuilder: (context, index) {
                if (index == viewModel.photos.length) {
                  return Center(
                    child: Padding(  
                      padding: EdgeInsets.all(10),
                      child: SizedBox(  
                        child: CircularProgressIndicator(),
                        height: 30,
                        width: 30,
                      ),
                    )
                  );
                } else {
                  final photo = viewModel.photos[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index, 
                    columnCount: 2, 
                    child: SlideAnimation( 
                      duration: Duration(milliseconds: 350),
                      verticalOffset: 50,
                      child: FadeInAnimation(
                        child: ImageCard(key: Key(photo.id), photo: photo,),
                      ),
                    )
                  );
                }
              }, 
              staggeredTileBuilder: (index) => index == viewModel.photos.length ? new StaggeredTile.fit(4) : new StaggeredTile.fit(2),
            ),
          )
        ),
        onRefresh: _onRefresh,
      ),
    );
  }
  _scrollListener() {
    if (_controller.offset == _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      print("[Debug]: reach the bottom");
      Provider.of<PhotosViewModel>(context, listen: false).fetchPhotos();
    }
  }
  Future<void> _onRefresh() async {
    await Provider.of<PhotosViewModel>(context, listen: false).fetchPhotos(isRefresh: true);
  }
}