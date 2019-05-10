import 'dart:convert';
import 'package:http/http.dart' show Client;

final _root = 'https://private-a8e48-hcidtest.apiary-mock.com/home';

class Repository {
  Client client = new Client();

  Future<Map<String, dynamic>> fetchApi() async {
    final response = await client.get('$_root');
    final parsedJson = json.decode(response.body);
    return parsedJson;
  }
}
