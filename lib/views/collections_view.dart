import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/components/collection_card.dart';
import 'package:pyxel/view_models/collections_view_model.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class CollectionsView extends StatefulWidget {
  CollectionsView({Key key}) : super(key: key);

  @override
  _CollectionsViewState createState() => _CollectionsViewState();
}

class _CollectionsViewState extends State<CollectionsView> {
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    Provider.of<CollectionsViewModel>(context, listen: false).fetchCollections();
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
    final viewModel = Provider.of<CollectionsViewModel>(context);
    print("[Build]: build widget.");
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
                    return CollectionCard(collection: viewModel.collections[index]);
                  },
                  childCount: viewModel.collections.length
                ),
              ),
            ),
            viewModel.collections.isNotEmpty ? SliverList(
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
      Provider.of<CollectionsViewModel>(context, listen: false).fetchCollections();
    }
  }
  Future<void> _onRefresh() async {
    await Provider.of<CollectionsViewModel>(context, listen: false).fetchCollections(isRefresh: true);
  }
}

