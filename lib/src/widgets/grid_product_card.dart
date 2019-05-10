import 'package:flutter/material.dart';

import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';

class GridProductCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String url;

  GridProductCard({this.name, this.imgUrl, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _sectionImg(imgUrl),
            _sectionName(name),
          ],
        ),
      ),
    );
  }

  Widget _sectionImg(String imgUrl) {
    if (imgUrl == null) {
      return SkeletonAnimation(
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
      );
    }
    return Image.network(
      imgUrl,
      fit: BoxFit.contain,
      height: 70.0,
    );
  }

  Widget _sectionName(String name) {
    if (name == null) {
      return SkeletonAnimation(
        child: Container(
          padding: EdgeInsets.all(150.0),
          width: 60,
          height: 13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[300]),
        ),
      );
    }
    return Text(
      name.replaceAll(RegExp('Pembiayaan'), ''),
      textAlign: TextAlign.center,
    );
  }

  _launchUrl(String url) async {
    if (url == null) {
      return () => {};
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
