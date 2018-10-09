import 'package:news/src/resources/news-api-provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds return a list of ids', () async {
    // setup of test case
    final sum = 1 + 3;
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    // expectation 
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns an item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id' : 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(123);

    expect(item.id, 123);

  });
}