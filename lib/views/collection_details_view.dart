import 'package:flutter/material.dart';
import '../components/tags_row.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/components/pop_button.dart';
import 'package:pyxel/models/collection.dart';
import 'package:pyxel/models/user.dart';
import 'package:pyxel/view_models/collection_details_view_model.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import '../components/image_card.dart';
import 'package:flutter/cupertino.dart';
import '../components/profile_info.dart';

class CollectionDetailsView extends StatelessWidget {
  const CollectionDetailsView({Key key, this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (context) => CollectionDetailsViewModel(id: id),
      child: _CollectionDetailsView(),
    );
  }
}

class _CollectionDetailsView extends StatefulWidget {
  _CollectionDetailsView({Key key}) : super(key: key);

  @override
  __CollectionDetailsViewState createState() => __CollectionDetailsViewState();
}

class __CollectionDetailsViewState extends State<_CollectionDetailsView> {

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    Provider.of<CollectionDetailsViewModel>(context, listen: false).fetchCollection();
    Provider.of<CollectionDetailsViewModel>(context, listen: false).fetchPhotos();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CollectionDetailsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Collection'),
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
        bottom: PreferredSize(  
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(0.4),
        ),
        leading: PopButton(color: Colors.white,),
      ),
      body: viewModel.collection == null ? CircularProgress() : SafeArea(
        child: RefreshIndicator(  
          onRefresh: _onRefresh,
          child: CustomScrollView(  
            controller: _controller,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverList( 
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.collection.title,
                          style: TextStyle( 
                            fontSize: Theme.of(context).textTheme.headline5.fontSize,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('Published on ${DateFormat('d MMM, yyyy').format(viewModel.collection.publishedAt)}'),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(  
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Photos',
                                style: TextStyle(  
                                  fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                viewModel.collection.totalPhotos.toString(),
                                style: TextStyle(  
                                  fontSize: Theme.of(context).textTheme.headline6.fontSize,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        viewModel.collection.description == null ? Container() : DescriptionRow(collection: viewModel.collection),
                        viewModel.collection.user == null ? Container() : CreatorRow(user: viewModel.collection.user),
                        viewModel.collection.tags.isEmpty ? Container() : Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TagsRow(tags: viewModel.collection.tags),
                        )
                      ],
                    ),
                  )
                ]),
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
              viewModel.photos.isEmpty ? (viewModel.isEmpty ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(  
                  child: Text('There\'s no photos in this collection.'),
                )
              ) : SliverFillRemaining(
                hasScrollBody: false,
                child: CircularProgress()
              ) ): SliverList(
                delegate: SliverChildListDelegate([
                  viewModel.photoEnd ? Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 10),  
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.grey,
                    ),
                  ) : Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: CircularProgress(),
                  )
                ]),
              ) 
            ],
          ),
        )
      )
    );
  }
  _scrollListener() {
    if (_controller.offset == _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      print("[Debug]: reach the bottom");
      Provider.of<CollectionDetailsViewModel>(context, listen: false).fetchPhotos();
    }
  }
  Future<void> _onRefresh() async {
    await Provider.of<CollectionDetailsViewModel>(context, listen: false).fetchPhotos(isRefresh: true);
  }
}

class DescriptionRow extends StatelessWidget {
  const DescriptionRow({
    Key key,
    @required this.collection,
  }) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(  
              fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            collection.description,
            style: Theme.of(context).textTheme.bodyText2
          ),
        ],
      ),
    );
  }
}

class CreatorRow extends StatelessWidget {
  const CreatorRow({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Creator',
            style: TextStyle(  
              fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 5),
          ProfileInfo(color: Colors.grey, user: user,)
        ],
      ),
    );
  }
}