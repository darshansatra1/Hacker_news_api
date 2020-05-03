import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/src/bloc/news_bloc.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  NewsBloc get newsBloc => GetIt.I<NewsBloc>();

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await newsBloc.clearCache();
        await newsBloc.fetchTopIds();
      },
    );
  }
}
