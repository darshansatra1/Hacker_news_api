import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _commentsFetcher = PublishSubject<int>();

  Stream<Map<int, Future<ItemModel>>> get fetchcomments =>
      _commentsOutput.stream;

  Function(int) get addComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (Map<int, Future<ItemModel>> cache, int id, int index) {
      cache[id] = _repository.fetchItem(id);
      cache[id].then((ItemModel item) {
        // print("Kids ${item.kids.toString()}");
        item.kids.forEach((int kidsId) {
          return addComments(kidsId);
        });
      });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentsOutput.close();
    _commentsFetcher.close();
  }
}
