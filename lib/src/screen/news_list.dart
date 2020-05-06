import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/src/bloc/news_bloc.dart';
import 'package:hacker_news/src/widget/news_list_tile.dart';
import 'package:hacker_news/src/widget/refresh.dart';

class NewsList extends StatelessWidget {
  NewsBloc get newsBloc => GetIt.I<NewsBloc>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                backgroundColor: Color(0xFFbb99ff),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Hacker News',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1],
                    colors: <Color>[Color(0xFFbb99ff), Color(0xFF9966ff)])),
            child: StreamBuilder(
              stream: newsBloc.topIds,
              builder:
                  (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent),
                  );
                }
                return Refresh(
                  child: ListView.builder(
                    dragStartBehavior: DragStartBehavior.down,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      newsBloc.fetchItem(snapshot.data[index]);
                      return NewsListTile(id: snapshot.data[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
