import 'package:flutter/material.dart';

import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ListArticleCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String url;

  ListArticleCard({this.name, this.imgUrl, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _sectionImg(imgUrl),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: _sectionName(name),
            ),
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
          height: 150.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
      );
    }
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
    );
  }

  Widget _sectionName(String name) {
    if (name == null) {
      return SkeletonAnimation(
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: 75,
          height: 13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[300]),
        ),
      );
    }
    return Text(
      name.replaceAll(RegExp('Pembiayaan'), ''),
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
