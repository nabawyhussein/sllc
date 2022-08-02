import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../global/errors/exeptions.dart';
import '../models/post_model_data_layer.dart';

abstract class PostLocalDataSource {
  Future<List<PostModelDataLayer>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModelDataLayer> PostModelDataLayers);
}

const CACHED_POSTS = "CACHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModelDataLayer> PostModelDataLayers) {
    List PostModelDataLayersToJson = PostModelDataLayers
        .map<Map<String, dynamic>>((PostModelDataLayer) => PostModelDataLayer.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(PostModelDataLayersToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModelDataLayer>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModelDataLayer> jsonToPostModelDataLayers = decodeJsonData
          .map<PostModelDataLayer>((jsonPostModelDataLayer) => PostModelDataLayer.fromJson(jsonPostModelDataLayer))
          .toList();
      return Future.value(jsonToPostModelDataLayers);
    } else {
      throw EmptyCacheException();
    }
  }
}