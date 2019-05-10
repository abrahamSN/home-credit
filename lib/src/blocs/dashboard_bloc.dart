import 'package:rxdart/rxdart.dart';

import 'package:connectivity/connectivity.dart';

import '../resources/repository.dart';

class DashboardBloc {
  final _repository = Repository();
  final _productSection = PublishSubject<List>();
  final _articleSection = PublishSubject<List>();
  final _connection = BehaviorSubject<bool>();

  Observable<List> get productSection => _productSection.stream;

  Observable<List> get articleSection => _articleSection.stream;

  Observable<bool> get connection => _connection.stream;

  fetchApi() async {
    var product;
    var article;

    _checkConnect().then((dynamic res) async {
      if(res == false) {
        _connection.add(false);
      } else {
        _connection.add(true);

        final parsedJson = await _repository.fetchApi();

        if (parsedJson['data'][0]['section'] == 'prouducts') {
          product = parsedJson['data'][0];
          article = parsedJson['data'][1];
        } else {
          product = parsedJson['data'][1];
          article = parsedJson['data'][0];
        }

        _productSection.add(product['items']);
        _articleSection.add(article['items']);
      }
    });
  }

  _checkConnect() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  dispose() {
    _productSection.close();
    _articleSection.close();
    _connection.close();
  }
}
