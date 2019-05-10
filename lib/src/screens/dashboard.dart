import 'package:flutter/material.dart';

import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../blocs/dashboard_provider.dart';
import '../widgets/grid_product_card.dart';
import '../widgets/list_article_card.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = DashboardProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe11931),
        title: Center(
          child: Text('Home Credit'),
        ),
      ),
      body: StreamBuilder(
        stream: bloc.connection,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('loading internet connection');
          } else if (snapshot.data == false) {
            return _bodyBuilderError(bloc);
          }
          return _bodyBuilder(bloc);
        },
      ),
    );
  }

  Widget _bodyBuilderError(DashboardBloc bloc) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment(0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/disconnect.png',
              width: 150.0,
            ),
            Text('You are disconnected!'),
            FlatButton.icon(
              onPressed: () => bloc.fetchApi(),
              icon: Icon(Icons.refresh),
              label: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyBuilder(DashboardBloc bloc) {
    return CustomScrollView(
      slivers: <Widget>[
        _productGrid(bloc),
        SliverStickyHeader(
          header: Container(
            height: 60.0,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Article section',
            ),
          ),
          sliver: _articleList(bloc),
        ),
      ],
    );
  }

  Widget _productGrid(DashboardBloc bloc) {
    return StreamBuilder(
      stream: bloc.productSection,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate((context, int index) {
              return GridProductCard();
            }, childCount: 6),
          );
        }
        return SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GridProductCard(
                name: snapshot.data[index]['product_name'],
                imgUrl: snapshot.data[index]['product_image'],
                url: snapshot.data[index]['link'],
              );
            },
            childCount: snapshot.data.length,
          ),
        );
      },
    );
  }

  Widget _articleList(DashboardBloc bloc) {
    return StreamBuilder(
      stream: bloc.articleSection,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, int index) {
                return ListArticleCard();
              },
              childCount: 5,
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListArticleCard(
                name: snapshot.data[index]['article_title'],
                imgUrl: snapshot.data[index]['article_image'],
                url: snapshot.data[index]['link'],
              );
            },
            childCount: snapshot.data.length,
          ),
        );
      },
    );
  }
}
