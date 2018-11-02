import 'dart:async';
import '../blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc)
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(itemId: snapshot.data[index]);
            },
          )
        );
      }
    );
  }


  // Widget buildList() {
  //   return ListView.builder(
  //     itemCount: 1000,
  //     itemBuilder: (context, int index) {
  //       return FutureBuilder(
  //         future:getFuture(),
  //         builder: (context, snapshot) {
  //           return Container(
  //             height: 80.0,
  //             child: snapshot.hasData ? Text('Im visible $index'): Text('I havent fetch data yet $index'),
  //           );
  //         },
  //       );
  //     }
  //   );
  // }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'hi'
    );
  }
}