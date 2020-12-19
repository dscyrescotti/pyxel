import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/components/image_card.dart';
import 'package:pyxel/view_models/photos_view_model.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

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
    print("[Build]: build widget.");
    return viewModel.photos.length == 0 ? CircularProgress() : SafeArea(
        child: CustomScrollView(  
          controller: _controller,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              snap: true,
              backgroundColor: Colors.white,
              title: Text('pyxel'),
              centerTitle: true,
              textTheme: Theme.of(context).textTheme,
              bottom: PreferredSize(  
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  height: 0.4,
                ),
                preferredSize: Size.fromHeight(0.4),
              ),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: _onRefresh,
              // builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance, refreshIndicatorExtent) => Icon(Icons.arrow_downward),
            ),
            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverWaterfallFlow(
                gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ImageCard(photo: viewModel.photos[index]);
                  },
                  childCount: viewModel.photos.length
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: CircularProgress(),
                )
              ]),
            )
          ],
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

