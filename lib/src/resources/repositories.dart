import 'package:hacker_news/src/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}

class Repository {
  List<Source> sources = <Source>[newsDbProvider, NewsApiProvider()];
  List<Cache> caches = <Cache>[newsDbProvider];

  Future<List<int>> fetchTopIds() async {
    for (var source in sources) {
      final ids = await source.fetchTopIds();
      if (ids != null) {
        return ids;
      }
    }
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;

    for (var source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}
