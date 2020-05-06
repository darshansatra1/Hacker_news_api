import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  NewsBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    print("Start");
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
    print("Done");
  }

  clearCache() {
    return _repository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, int index) {
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
