import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/models/photo.dart';
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
                    ProfileRow(color: color, viewModel: viewModel, photo: photo),
                    photo.description != null ? DescriptionRow(photo: photo) : Container(),
                    TagsRow(tags: photo.tags, color: color,)
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

class TagsRow extends StatelessWidget {
  const TagsRow({
    Key key,
    this.tags,
    this.color,
  }) : super(key: key);
  final List<Tag> tags;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final _color = color.computeLuminance() < 0.5 ? Colors.white : Colors.black;
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Tags(  
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.start,
        itemCount: tags.length,
        itemBuilder: (index) => ItemTags(
          textStyle: TextStyle(  
            fontSize: Theme.of(context).textTheme.overline.fontSize,
            fontWeight: FontWeight.bold
          ),
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          index: index, 
          title: tags[index].title,
          elevation: 0,
          textActiveColor: _color,
          activeColor: color,
        ),
      ),
    );
  }
}

class DescriptionRow extends StatelessWidget {
  const DescriptionRow({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.yellow, 
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
            photo.description,
            style: Theme.of(context).textTheme.bodyText2
          ),
        ],
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    Key key,
    @required this.color,
    @required this.viewModel,
    @required this.photo,
  }) : super(key: key);

  final Color color;
  final PhotoDetailsViewModel viewModel;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(  
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
                style: TextStyle(  
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '@${photo.user.username}',
                style: TextStyle(  
                  fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                  fontWeight: FontWeight.normal
                ),
              )
            ],
          )
        ],
      ), 
    );
  }
}

