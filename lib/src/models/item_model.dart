import 'dart:convert';

class ItemModel {
  int id;
  bool deleted;
  String type;
  String by;
  int time;
  String text;
  bool dead;
  int parent;
  List<int> kids;
  String url;
  int score;
  String title;
  int descendants;
  ItemModel(
      {this.id,
      this.deleted,
      this.type,
      this.by,
      this.time,
      this.text,
      this.dead,
      this.parent,
      this.kids,
      this.url,
      this.score,
      this.title,
      this.descendants});

  ItemModel.fromJson(Map<String, dynamic> item)
      : id = item['id'] ?? 23069023,
        deleted = item['deleted'] ?? false,
        type = item['type'] ?? '',
        by = item['by'] ?? 'No author found',
        time = item['time'] ?? 0,
        text = item['text'] ?? '',
        dead = item['dead'] ?? false,
        parent = item['parent'] ?? 0,
        kids = item['kids'] == null ? [] : item['kids'].cast<int>(),
        url = item['url'],
        score = item['score'] ?? 0,
        title = item['title'] ?? '',
        descendants = item['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> item)
      : id = item['id'],
        deleted = item['deleted'] == 1,
        type = item['type'],
        by = item['by'],
        time = item['time'],
        text = item['text'],
        dead = item['dead'] == 1,
        parent = item['parent'],
        kids = jsonDecode(item['kids']).cast<int>(),
        url = item['url'],
        score = item['score'],
        title = item['title'],
        descendants = item['descendants'];

  toMap() => <String, dynamic>{
        'id': id,
        'deleted': deleted ? 1 : 0,
        'type': type,
        'by': by,
        'time': time,
        'text': text,
        'dead': dead ? 1 : 0,
        'parent': parent,
        'kids': jsonEncode(kids),
        'url': url,
        'score': score,
        'title': title,
        'descendants': descendants
      };
}
