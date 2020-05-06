import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/src/bloc/comments_bloc.dart';
import 'package:hacker_news/src/bloc/news_bloc.dart';
import 'package:hacker_news/src/screen/news_details.dart';
import 'package:hacker_news/src/screen/news_list.dart';

import 'models/item_model.dart';

abstract class Routes {
  static NewsBloc get newsBloc => GetIt.I<NewsBloc>();
  static Route materialPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) {
          // final NewsBloc newsBloc = GetIt.I<NewsBloc>();
          newsBloc.fetchTopIds();
          return NewsList();
        });
      case "/id":
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              final CommentsBloc commentsBloc = GetIt.I<CommentsBloc>();
              ItemModel item = settings.arguments;
              commentsBloc.addComments(item.id);
              return NewsDetail();
            });
    }
  }
}
