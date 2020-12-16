import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/models/photo.dart';
import 'package:pyxel/view_models/photo_details_view_model.dart';
import 'package:pyxel/components/sliver_header.dart';
import 'package:numeral/numeral.dart';
import '../utils/darken.dart';

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
                    TagsRow(tags: photo.tags, color: color,),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(  
                        children: [
                          StatisticBox(title: 'Likes', icon: Icons.star, value: Numeral(photo.likes).value(), color: color,),
                          StatisticBox(title: 'Downloads', icon: Icons.download_rounded, value: Numeral(photo.downloads).value(), color: color,),
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
      padding: tags.length == 0 ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Tags(  
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.start,
        itemCount: tags.length,
        itemBuilder: (index) => ItemTags(
          textStyle: TextStyle(  
            fontSize: Theme.of(context).textTheme.overline.fontSize,
            fontWeight: FontWeight.normal
          ),
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          index: index, 
          title: tags[index].title,
          elevation: 0,
          textActiveColor: _color,
          activeColor: darken(color).withOpacity(0.7),
        ),
      ),
    );
  }
}

class StatisticBox extends StatelessWidget {
  const StatisticBox({Key key, this.title, this.value, this.icon, this.color}) : super(key: key);

  final String value;
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final _color = color.computeLuminance() < 0.5 ? Colors.white : Colors.black;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(  
          borderRadius: BorderRadius.circular(10),
          color: darken(color).withOpacity(0.7)
        ),
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(  
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
                fontWeight: FontWeight.bold,
                color: _color
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(  
                  icon,
                  size: 23,
                  color: _color,
                ),
                Text(
                  title,
                  style: TextStyle(  
                    fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                    fontWeight: FontWeight.w600,
                    color: _color
                  ),
                ),
              ],
            )
          ],
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
      child: Row( 
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration( 
              shape: BoxShape.circle,
              color: darken(color).withOpacity(0.8),
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

