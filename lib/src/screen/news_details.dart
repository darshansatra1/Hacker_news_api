import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hacker_news/src/bloc/comments_bloc.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/widget/comment.dart';
import 'package:hacker_news/src/widget/loading_container.dart';

class NewsDetail extends StatelessWidget {
  CommentsBloc get commentsBloc => GetIt.I<CommentsBloc>();
  @override
  Widget build(BuildContext context) {
    final ItemModel itemArgs = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                stretch: true,
                floating: false,
                backgroundColor: Color(0xFFbb99ff),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(
                    itemArgs.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                expandedHeight: 200,
              )
            ];
          },
          body: buildBody(itemArgs),
        ),
      ),
    );
  }

  Widget buildBody(ItemModel itemArgs) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        stops: [0.5, 1],
        colors: <Color>[Color(0xFFbb99ff), Color(0xFF9966ff)],
      )),
      child: StreamBuilder(
          stream: commentsBloc.fetchcomments,
          builder: (BuildContext context,
              AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
            if (!snapshot.hasData) {
              return LoadingContainer();
            }

            final itemFuture = snapshot.data[itemArgs.id];

            return FutureBuilder(
              future: itemFuture,
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return LoadingContainer();
                }
                return buildList(itemSnapshot.data, snapshot.data);
              },
            );
          }),
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    final counter = 0;

    final comments = item.kids.map((itemId) {
      return Comment(
        counter: counter,
        id: itemId,
        itemMap: itemMap,
      );
    }).toList();

    children.addAll(comments);

    return ListView(
      physics: BouncingScrollPhysics(),
      addSemanticIndexes: true,
      dragStartBehavior: DragStartBehavior.down,
      shrinkWrap: true,
      children: children,
    );
  }

  Widget buildTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
    );
  }
}
