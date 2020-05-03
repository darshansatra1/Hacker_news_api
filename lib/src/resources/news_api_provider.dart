import 'dart:convert';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repositories.dart';
import 'package:http/http.dart' show Client;

final _url = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_url/topstories.json');

    List<int> ids = json.decode(response.body).cast<int>();
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_url/item/$id.json');
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      ItemModel item = ItemModel.fromJson(parsedJson);
      return item;
    }
    return null;
  }
}
