import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/src/bloc/news_bloc.dart';
import 'package:hacker_news/src/models/item_model.dart';

import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int id;
  NewsListTile({this.id});

  NewsBloc get newsBloc => GetIt.I<NewsBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: newsBloc.items,
      builder: (_, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[id],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Card(
      elevation: 2,
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          item.title,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFd9b3ff)),
        ),
        subtitle: Text(
          '${item.score} points',
          style: TextStyle(color: Colors.white),
        ),
        trailing: Column(
          children: [
            Icon(Icons.mode_comment),
            Text('${item.descendants}'),
          ],
        ),
      ),
    );
  }
}
