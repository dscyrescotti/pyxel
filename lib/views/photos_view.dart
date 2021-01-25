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
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(  
        controller: _controller,
        slivers: [
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
          viewModel.photos.isNotEmpty ? SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: CircularProgress(),
              )
            ]),
          ) : SliverFillRemaining(
            hasScrollBody: false,
            child: CircularProgress()
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

