import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:intl/intl.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int counter;
  final int id;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.counter, this.id, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[id],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        final item = snapshot.data;

        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        var date = DateTime.fromMillisecondsSinceEpoch(item.time * 1000);
        var time = formatter.format(now);
        var diff = date.difference(now);
        final children = <Widget>[
          Row(
            children: [
              SizedBox(
                width: counter * 16.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_drop_up),
                        Text(
                          item.by,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        // Text(DateTime.fromMicrosecondsSinceEpoch(item.time).toString())
                        Text(
                            '- Updated ${diff.inMinutes.toString()} Minutes age')
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.only(bottom: counter * 2.0, right: 10),
                      color: Colors.transparent,
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          buildText(item.text),
                          style: TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ];
        item.kids.forEach((itemId) {
          children.add(Comment(
            counter: counter + 1,
            id: itemId,
            itemMap: itemMap,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  String buildText(String text) {
    return text
        .replaceAll('&#x27', "'")
        .replaceAll("<p>", "\n\n")
        .replaceAll("</p>", '')
        .replaceAll("&quot;", '""')
        .replaceAll("';", "'")
        .replaceAll("&#x2F;", "/")
        .replaceAll("<a", "\n")
        .replaceAll("</a>", "\n")
        .replaceAll("&gt;", ">");
  }
}
