import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final _repository =  Repository();
  final _items = BehaviorSubject<int>();

  Observable<List<int>> get topIds => _topIds.stream;

  //Getters to streams
  // // Dont do this bad
  // get items => _items.stream.transform(_itemsTransformer());

  Function(int) get fetchItem => _items.sink.add;

  fetchTopds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose(){
    _topIds.close();
    _items.close();
  }

}