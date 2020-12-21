import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import '../components/tags_row.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/models/photo.dart';
import 'package:pyxel/view_models/photo_details_view_model.dart';
import 'package:pyxel/components/sliver_header.dart';
import '../utils/numeral.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../components/statistic_box.dart';
import '../components/profile_info.dart';
import 'package:intl/intl.dart';

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
                    ProfileRow(color: color, photo: photo),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Created on ${DateFormat('d MMM, yyyy').format(photo.createdAt)}'),
                    ),
                    photo.description != null ? DescriptionRow(photo: photo) : Container(),
                    StatisticRow(photo: photo, color: color),
                    ExifRow(photo: photo),
                    photo.location != null ? LocationRow(photo: photo) : Container(),
                    TagsRow(tags: photo.tags, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5), padding: EdgeInsets.only(bottom: 10),),
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

class LocationRow extends StatelessWidget {
  const LocationRow({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(  
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(  
                Icons.place_rounded
              ),
              SizedBox(width: 5),
              Text(
                photo.location.name(),
                style: TextStyle(  
                  fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          photo.location.position != null && photo.location.position.isNotNull() ? Container(  
            margin: EdgeInsets.only(top: 10),
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FlutterMap(  
                options: MapOptions(
                  interactive: false,  
                  center: LatLng(photo.location.position.latitude, photo.location.position.longitude),
                  zoom: 13.0
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: "https://api.mapbox.com/styles/v1/dscyrescotti/ckird7b964n5u17s16s6s90mf/tiles/256/{z}/{x}/{y}@2x?access_token=${DotEnv().env['MAPBOX_TOKEN']}",
                    additionalOptions: {
                      "accessToken": DotEnv().env['MAPBOX_TOKEN'],
                      "id": "mapbox.mapbox-streets-v8"
                    }
                  ),
                  new MarkerLayerOptions(
                    markers: [
                      Marker(
                        point: LatLng(photo.location.position.latitude, photo.location.position.longitude),
                        builder: (context) => Icon(  
                          Icons.place_rounded,
                          size: 30,
                          color: Colors.red,
                        )
                      )
                    ]
                  )
                ],
              ),
            ),
          ) : Container()
        ],
      ),
    );
  }
}

class ExifRow extends StatelessWidget {
  const ExifRow({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Exif',
              style: TextStyle(  
                fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Row(  
            children: [
              ExifBox(value: photo.exif.aperture ?? '-', title: 'Aperture',),
              ExifBox(value: photo.exif.exposureTime ?? '-', title: 'Exposure Time',)
            ],
          ),
          Row(  
            children: [
              ExifBox(value: photo.exif.focalLength ?? '-', title: 'Focal Length',),
              ExifBox(value: (photo.exif.iso ?? '-').toString(), title: 'ISO',)
            ],
          ),
          Row(  
            children: [
              ExifBox(value: photo.exif.make ?? '-', title: 'Make',),
              ExifBox(value: photo.exif.model ?? '-', title: 'Model',)
            ],
          ),
        ],
      ),
    );
  }
}

class ExifBox extends StatelessWidget {
  ExifBox({Key key, this.title, this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(  
                fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              title,
              style: TextStyle(  
                fontSize: Theme.of(context).textTheme.caption.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticRow extends StatelessWidget {
  const StatisticRow({
    Key key,
    @required this.photo,
    @required this.color,
  }) : super(key: key);

  final Photo photo;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(  
        children: [
          StatisticBox(title: 'Views', value: Numeral(photo.views).value(),),
          StatisticBox(title: 'Likes', value: Numeral(photo.likes).value(),),
          StatisticBox(title: 'Downloads', value: Numeral(photo.downloads).value(),),
        ],
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
    @required this.photo,
  }) : super(key: key);

  final Color color;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(  
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: ProfileInfo(color: color, user: photo.user),
    );
  }
}

