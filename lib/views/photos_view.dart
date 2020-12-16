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
    return Scaffold(
      appBar: AppBar(  
        title: Text("pyxel"),
        centerTitle: true,
      ),
      body: viewModel.photos.length == 0 ? CircularProgress() : RefreshIndicator(
        child: WaterfallFlow.builder(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          controller: _controller,
          padding: EdgeInsets.all(10),
          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: viewModel.photos.length,
          itemBuilder: (context, index) => ImageCard(photo: viewModel.photos[index]),
          cacheExtent: 1000,
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